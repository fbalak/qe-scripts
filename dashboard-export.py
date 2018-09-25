import requests

# link to server with grafana api
api_url = ""

# list of dashboards to export
dashboards = ["brick", "cluster", "host", "volume"]
data = {key: [] for key in dashboards}

for d in dashboards:
    r = requests.get('{}:3000/api/dashboards/db/{}-dashboard'.format(
        api_url, d))
    rows = r.json()["dashboard"]["rows"]
    for row in rows:
        data[d].append({row["title"]:[]})
        for panel in row["panels"]:
            if panel["title"]:
                print("{},{},{}".format(d,row["title"],panel["title"]))
                data[d][-1][row["title"]].append(panel["title"])
            elif "displayName" in panel.keys() and panel["displayName"]:
                print("{},{},{}".format(d,row["title"],panel["displayName"]))
                data[d][-1][row["title"]].append(panel["displayName"])
print(data)
