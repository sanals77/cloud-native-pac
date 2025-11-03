{{- define "api.name" -}}
api
{{- end }}

{{- define "api.fullname" -}}
{{ include "api.name" . }}
{{- end }}

