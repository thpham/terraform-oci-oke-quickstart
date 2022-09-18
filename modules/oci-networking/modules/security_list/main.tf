# Copyright (c) 2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
# 

resource "oci_core_security_list" "security_list" {
  compartment_id = var.compartment_ocid
  display_name   = var.display_name
  vcn_id         = var.vcn_id
  freeform_tags  = var.security_list_tags.freeformTags
  defined_tags   = var.security_list_tags.definedTags

  dynamic "ingress_security_rules" {
    for_each = var.ingress_security_rules
    content {
      description = ingress_security_rules.value.description
      source      = ingress_security_rules.value.source
      source_type = ingress_security_rules.value.source_type
      protocol    = ingress_security_rules.value.protocol
      stateless   = ingress_security_rules.value.stateless
      tcp_options {
        max = ingress_security_rules.value.tcp_options.max
        min = ingress_security_rules.value.tcp_options.min
        source_port_range {
          max = ingress_security_rules.value.tcp_options.source_port_range.max
          min = ingress_security_rules.value.tcp_options.source_port_range.min
        }
      }
      udp_options {
        max = ingress_security_rules.value.udp_options.max
        min = ingress_security_rules.value.udp_options.min
        source_port_range {
          max = ingress_security_rules.value.udp_options.source_port_range.max
          min = ingress_security_rules.value.udp_options.source_port_range.min
        }
      }
      icmp_options {
        type = ingress_security_rules.value.icmp_options.type
        code = ingress_security_rules.value.icmp_options.code
      }
    }
  }

  dynamic "egress_security_rules" {
    for_each = var.egress_security_rules
    content {
      description      = egress_security_rules.value.description
      destination      = egress_security_rules.value.destination
      destination_type = egress_security_rules.value.destination_type
      protocol         = egress_security_rules.value.protocol
      stateless        = egress_security_rules.value.stateless
      tcp_options {
        max = egress_security_rules.value.tcp_options.max
        min = egress_security_rules.value.tcp_options.min
        source_port_range {
          max = egress_security_rules.value.tcp_options.source_port_range.max
          min = egress_security_rules.value.tcp_options.source_port_range.min
        }
      }
      udp_options {
        max = egress_security_rules.value.udp_options.max
        min = egress_security_rules.value.udp_options.min
        source_port_range {
          max = egress_security_rules.value.udp_options.source_port_range.max
          min = egress_security_rules.value.udp_options.source_port_range.min
        }
      }
      icmp_options {
        type = egress_security_rules.value.icmp_options.type
        code = egress_security_rules.value.icmp_options.code
      }
    }
  }

  count = var.create_security_list ? 1 : 0
}