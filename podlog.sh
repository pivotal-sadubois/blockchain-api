kubectl logs -n blockchain $(kubectl -n blockchain get pod | grep deployment | grep -v termin | awk '{ print $1 }') workload -f
