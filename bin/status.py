#!/usr/bin/env python

# pip install kubernetes

from pprint import pprint
from kubernetes import client, config
from kubernetes.client.rest import ApiException
import json
import urllib2
from datetime import datetime, tzinfo
import dateutil.relativedelta
import time

remote = False

def rpc_call_remote(pod_id, method, params):
    resource_path = '/api/v1/namespaces/{namespace}/pods/{name}/proxy'.replace('{format}', 'json')
    collection_formats = {}
    path_params = {}
    path_params['name'] = pod_id
    path_params['namespace'] = "default"
    query_params = {}
    query_params['path'] = ":8545"
    header_params = {}
    header_params['Accept'] = api.api_client.select_header_accept(['*/*'])
    header_params['Content-Type'] = api.api_client.select_header_content_type(['*/*'])
    body_params = rpc_payload(method, params)
    auth_settings = ['BearerToken']
    form_params = []
    local_var_files = {}
    try:
        api_response = api.api_client.call_api(resource_path, 'POST',
                                               path_params,
                                               query_params,
                                               header_params,
                                               body=body_params,
                                               post_params=form_params,
                                               files=local_var_files,
                                               response_type="object",
                                               auth_settings=auth_settings,
                                               collection_formats=collection_formats)
        x = api_response[0]
        if not x.has_key("result"):
            pprint(x)
        return x["result"]
    except ApiException as e:
        print("Exception when calling CoreV1Api: %s\n" % e)

def rpc_call_local(pod_id, method, params):
    url = 'http://%s:8545' % pod_id
    req = urllib2.Request(url)
    req.add_header('Content-Type', 'application/json')
    body_params = rpc_payload(method, params)
    response = urllib2.urlopen(req, json.dumps(body_params))
    x = json.load(response)
    if not x.has_key("result"):
        pprint(x)
    return x["result"]


def rpc_payload(method, params):
    payload = {
        "jsonrpc":"2.0",
        "method": method,
        "params": params,
        "id": 1,
    }
    # s = json.dumps(payload)
    # print("Json: %s" % s)
    return payload

def get_nodes_remote():
    ret = api.list_namespaced_pod("default", watch=False)
    active = filter(lambda x: x.status.phase == "Running" and x.metadata.labels["type"] == 'node', ret.items)
    full = map(lambda x: {"id": x.metadata.name, "vendor": x.metadata.labels["vendor"], "version": x.metadata.labels["version"]}, active)
    return full

def get_nodes_local():
    nodes = [
        {"id": "geth-3586-svc", "vendor": "Geth", "version": "3.5.86"},
        {"id": "geth-4000-svc", "vendor": "Geth", "version": "4.0.0"},
        {"id": "geth-4102-svc", "vendor": "Geth", "version": "4.1.2"},
        {"id": "parity-168-svc", "vendor": "Parity", "version": "1.6.8"},
        {"id": "parity-169-svc", "vendor": "Parity", "version": "1.6.9"},
        {"id": "parity-179-svc", "vendor": "Parity", "version": "1.7.9"},
    ]
    return nodes


def get_height(node_id):
    return rpc_call(node_id, "eth_blockNumber", [])


def get_block(node_id, num):
    if type(num) is int:
        num=hex(num)
    return rpc_call(node_id, "eth_getBlockByNumber", [num, False])

# ----

def rpc_call(pod_id, method, params):
    if remote:
        return rpc_call_remote(pod_id, method, params)
    return rpc_call_local(pod_id, method, params)

def get_nodes():
    if remote:
        return get_nodes_remote()
    return get_nodes_local()

def timediff(delta):
    import math
    day = 60 * 60 * 24
    if delta < 5 * 60:
        return "%d seconds" % delta
    elif delta < 60 * 60:
        return "%d minutes" % (delta / 60)
    elif delta < day:
        return "%0.1f hours" % (delta / 60 / 60)
    else:
        days = math.ceil(delta / day)
        return "%0.1f days" % (delta / day)

def list():
    pods = get_nodes()
    now = datetime.now()
    for pod in pods:
        height = get_height(pod["id"])
        block = get_block(pod["id"], height)
        #time = dateutil.relativedelta.relativedelta(datetime.utcfromtimestamp(int(block["timestamp"], 16)), now)
        timedelta = time.mktime(now.timetuple()) - int(block["timestamp"], 16)
        print("Node %s %s at %d (%s ago)" % (pod["vendor"], pod["version"], int(height, 16), timediff(timedelta)))
        #hash = api.get_block(pod_id, height)["hash"]
        for h in (1920000, 2500000, 3000000, 4999999, 5000000, 5000001):
            if int(height, 16) >= h:
                b = get_block(pod["id"], hex(h))
                if b:
                    print("      %s\t%s" % (h, b["hash"]))


if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1 and sys.argv[1] == 'remote':
        remote = True
        config.load_kube_config()
        api = client.CoreV1Api()
    list()
