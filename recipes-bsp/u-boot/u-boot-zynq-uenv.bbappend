def uenv_populate(d):
    # populate the environment values
    env = {}

    env["ethaddr"] = "00:ab:f1:fa:00:22"

    env["machine_name"] = d.getVar("MACHINE")

    env["kernel_image"] = d.getVar("KERNEL_IMAGETYPE")
    env["kernel_load_address"] = d.getVar("KERNEL_LOAD_ADDRESS")

    env["devicetree_image"] = bootfiles_dtb_filepath(d)
    env["devicetree_load_address"] = d.getVar("DEVICETREE_LOAD_ADDRESS")

    env["bootargs"] = d.getVar("KERNEL_BOOTARGS")

    env["loadkernel"] = "fatload mmc 0 ${kernel_load_address} ${kernel_image}"
    env["loaddtb"] = "fatload mmc 0 ${devicetree_load_address} ${devicetree_image}"
    env["set_sfp"] = "echo **************** && echo *** IL Guard *** && echo **************** && echo set Marvell 88e1512 to SFP mode && mw e000b000 00000010 && mw e000b004 080c0000 && mii write 0 16 12 && mii write 0 14 0201 && mii write 0 14 8201 && mii read 0 0-1f && mii write 0 16 1 && mii write 0 1a 0047 && mii write 0 0 9140 && mii write 0 16 3 && mii write 0 10 0501 && mii write 0 11 4415 && mii write 0 16 0"
    
    env["bootkernel"] = "run set_sfp && run loadkernel && run loaddtb && " + uboot_boot_cmd(d) + " ${kernel_load_address} - ${devicetree_load_address}"

    # default uenvcmd does not load bitstream
    env["uenvcmd"] = "run bootkernel"

    bitstream, bitstreamtype = bootfiles_bitstream(d)
    if bitstream:
        env["bitstream_image"] = bitstream
        env["bitstream_load_address"] = "0x100000"

        # if bitstream is "bit" format use loadb, otherwise use load
        env["bitstream_type"] = "loadb" if bitstreamtype else "load"

        # load bitstream first with loadfpa
        env["loadfpga"] = "fatload mmc 0 ${bitstream_load_address} ${bitstream_image} && fpga ${bitstream_type} 0 ${bitstream_load_address} ${filesize}"
        env["uenvcmd"] = "run loadfpga && run bootkernel"

    return env
