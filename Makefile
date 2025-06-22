.PHONY: disk clean mbr
disk:
	dd if=/dev/zero of=disk.img bs=5M count=5

mbr: 
	echo "label: dos" | sfdisk disk.img

clean:
	rm disk.img