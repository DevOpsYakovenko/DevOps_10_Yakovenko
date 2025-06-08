import requests

base_url = "http://127.0.0.1:5000"

def log(response):
    print("Status:", response.status_code)
    print("Text:", response.text)

# GET all
log(requests.get(f"{base_url}/students"))

# POST x3
students = [
    {"first_name": "Anna", "last_name": "Smith", "age": 22},
    {"first_name": "Ivan", "last_name": "Smith", "age": 25},
    {"first_name": "Kristina", "last_name": "Yakovenko", "age": 31}
]

for student in students:
    log(requests.post(f"{base_url}/students", json=student))

# GET all
log(requests.get(f"{base_url}/students"))

# PATCH
log(requests.patch(f"{base_url}/students/2", json={"age": 26}))

# GET by id
log(requests.get(f"{base_url}/students/2"))

# PUT
log(requests.put(f"{base_url}/students/3", json={
    "first_name": "Kristina",
    "last_name": "Petrenko",
    "age": 33
}))

# GET by id
log(requests.get(f"{base_url}/students/3"))

# GET all
log(requests.get(f"{base_url}/students"))

# DELETE
log(requests.delete(f"{base_url}/students/1"))

# GET all
log(requests.get(f"{base_url}/students"))
