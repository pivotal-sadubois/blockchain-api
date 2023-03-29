SOURCE_IMAGE = os.getenv("SOURCE_IMAGE", default='nitashav.azurecr.io/tap-dev/blockchain-api-source/blockchain-api-source')
LOCAL_PATH = os.getenv("LOCAL_PATH", default='.')
NAMESPACE = os.getenv("NAMESPACE", default='default')
OUTPUT_TO_NULL_COMMAND = os.getenv("OUTPUT_TO_NULL_COMMAND", default=' > /dev/null ')
allow_k8s_contexts('tdh-vsphere-sadubois-tap')

k8s_custom_deploy(
    'blockchain-api',
    apply_cmd="tanzu apps workload apply -f config/workload-postgres.yaml --debug --live-update" +
              " --local-path " + LOCAL_PATH +
              " --source-image " + SOURCE_IMAGE +
              " --namespace " + NAMESPACE +
              " --yes " +
              OUTPUT_TO_NULL_COMMAND +
              " && kubectl get workload blockchain-api --namespace " + NAMESPACE + " -o yaml",
    delete_cmd="tanzu apps workload delete -f config/workload.yaml --namespace " + NAMESPACE + " --yes",
    deps=['pom.xml', './target/classes'],
    container_selector='workload',
    live_update=[
      sync('./target/classes', '/workspace/BOOT-INF/classes')
    ]
)

k8s_resource('blockchain-api', port_forwards=["8080:8080"],
            extra_pod_selectors=[{'serving.knative.dev/service': 'blockchain-api'}])
