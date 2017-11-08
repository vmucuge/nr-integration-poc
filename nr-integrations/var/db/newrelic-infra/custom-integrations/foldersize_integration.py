#!/usr/bin/env python
import argparse
import json
import logging
import os
import subprocess

class IntegrationData:
    def __init__(self, name, protocol_version, integration_version):
        self.name = name
        self.protocol_version = protocol_version
        self.integration_version = integration_version
        self.inventory = {}
        self.metrics = []
        self.events = []

    def addInventory(self, item, key, value):
        self.inventory.setdefault(item, {})[key] = value

    def addMetric(self, metric_dict):
        self.metrics.append(metric_dict)

def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument('-v', default=False, dest='verbose', action='store_true',
                        help='Print more information to logs')
    parser.add_argument('-p', default=False, dest='pretty', action='store_true',
                        help='Print pretty formatted JSON')
    parser.add_argument('--folder', default="/", help="directory path")
    args, unknown = parser.parse_known_args()
    return args


if __name__ == "__main__":
    # Setup the integration's command line parameters
    args = parse_arguments()

    # Setup logging, redirect logs to stderr and configure the log level.
    logger = logging.getLogger("infra")
    logger.addHandler(logging.StreamHandler())
    if args.verbose:
        logger.setLevel(logging.DEBUG)
    else:
        logger.setLevel(logging.INFO)

    # Initialize the output object
    data = IntegrationData("com.vgmorg.foldersize_integration", "1", "1.0.0")

    # Build the metrics dictionary
    metric = {
        "event_type": "FolderSize",
    }

    # Get ENVIRONMENT variable set by the agent
    env = os.getenv("ENVIRONMENT")
    if env:
        metric["environment"] = env

    pipe = subprocess.Popen(["du", "-shm", args.folder], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    du_output = pipe.communicate()
    metric[args.folder] = str(du_output).split('\\t')[0]

    data.addMetric(metric)

    if args.pretty:
        print json.dumps(data.__dict__, indent=4)
    else:
        print json.dumps(data.__dict__)
