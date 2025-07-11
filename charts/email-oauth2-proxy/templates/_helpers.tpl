{{/*
Namespace
*/}}
{{- define "email-oauth2-proxy.namespace" -}}
{{- if eq .Release.Namespace "default" }}
{{- print "email-oauth2-proxy" }}
{{- else}}
{{- .Release.Namespace }}
{{- end }}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "email-oauth2-proxy.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "email-oauth2-proxy.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "email-oauth2-proxy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
ServiceAccount
*/}}
{{- define "email-oauth2-proxy.serviceAccountName" -}}
{{- include "email-oauth2-proxy.fullname" .}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "email-oauth2-proxy.labels" -}}
helm.sh/chart: {{ include "email-oauth2-proxy.chart" . }}
{{ include "email-oauth2-proxy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "email-oauth2-proxy.selectorLabels" -}}
app.kubernetes.io/name: {{ include "email-oauth2-proxy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
