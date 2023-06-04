rule = {
    matches = {
        {
            { "node.name", "equals", "alsa_card.pci-0000_28_00.4" },
        },
    },
    apply_properties = {
        ["node.description"] = "System Output",
    },
}

table.insert(alsa_monitor.rules, rule)
