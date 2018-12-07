project:
	$(eval PROJECT := $(shell gcloud config get-value project 2>/dev/null))

cloudbuild: project
	gcloud builds submit --project $(PROJECT) --tag gcr.io/$(PROJECT)/nvidia-gpu-device-plugin:latest .

del-pod:
	kubectl -n kube-system delete pod -l k8s-app=nvidia-gpu-device-plugin

desc-pod:
	kubectl -n kube-system describe pod -l k8s-app=nvidia-gpu-device-plugin

pod:
	$(eval POD := $(shell kubectl -n kube-system get pod -l k8s-app=nvidia-gpu-device-plugin -o name))

pod-logs: pod
	kubectl -n kube-system logs ${POD}
