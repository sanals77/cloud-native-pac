package k8s.pod_security

#
# normalize input: sometimes helm template gives multiple YAML docs,
# sometimes it's just one. So we create a "docs" array either way.
#
docs := input.documents if {
  input.documents
}

docs := [input] if {
  not input.documents
}

# ---- rule 1: container must runAsNonRoot ----
deny_run_as_non_root[msg] if {
  some d_idx
  d := docs[d_idx]
  d.kind == "Deployment"

  some c_idx
  c := d.spec.template.spec.containers[c_idx]

  not c.securityContext.runAsNonRoot

  msg := sprintf("%s/%s: container %s must runAsNonRoot",
    [d.kind, d.metadata.name, c.name])
}

# ---- rule 2: container must have resources ----
deny_resources[msg] if {
  some d_idx2
  d2 := docs[d_idx2]
  d2.kind == "Deployment"

  some c_idx2
  c2 := d2.spec.template.spec.containers[c_idx2]

  not c2.resources

  msg := sprintf("%s/%s: container %s must set resources",
    [d2.kind, d2.metadata.name, c2.name])
}

# ---- rule 3: container must have resource limits ----
deny_resource_limits[msg] if {
  some d_idx3
  d3 := docs[d_idx3]
  d3.kind == "Deployment"

  some c_idx3
  c3 := d3.spec.template.spec.containers[c_idx3]

  not c3.resources.limits

  msg := sprintf("%s/%s: container %s must set resource limits",
    [d3.kind, d3.metadata.name, c3.name])
}

# ---- final deny: merge all rule results ----
deny[msg] if {
  msg := data.k8s.pod_security.deny_run_as_non_root[_]
}

deny[msg] if {
  msg := data.k8s.pod_security.deny_resources[_]
}

deny[msg] if {
  msg := data.k8s.pod_security.deny_resource_limits[_]
}
