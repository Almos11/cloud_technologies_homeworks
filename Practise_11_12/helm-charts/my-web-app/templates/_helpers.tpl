{{- define "my-web-app.name" -}}
{{- default .Chart.Name .Values.nameOverride -}}
{{- end -}}

{{- define "my-web-app.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "my-web-app.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "my-web-app.labels" -}}
app.kubernetes.io/name: {{ include "my-web-app.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "my-web-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "my-web-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "my-web-app.backendSelectorLabels" -}}
{{ include "my-web-app.selectorLabels" . }}
app.kubernetes.io/component: backend
{{- end -}}

{{- define "my-web-app.frontendSelectorLabels" -}}
{{ include "my-web-app.selectorLabels" . }}
app.kubernetes.io/component: frontend
{{- end -}}
