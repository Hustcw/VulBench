static void ehci_class_init(ObjectClass *klass, void *data)

{

    DeviceClass *dc = DEVICE_CLASS(klass);

    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);

    EHCIPCIInfo *i = data;



    k->init = usb_ehci_pci_initfn;

    k->vendor_id = i->vendor_id;

    k->device_id = i->device_id;

    k->revision = i->revision;

    k->class_id = PCI_CLASS_SERIAL_USB;

    k->config_write = usb_ehci_pci_write_config;


    dc->vmsd = &vmstate_ehci_pci;

    dc->props = ehci_pci_properties;

}