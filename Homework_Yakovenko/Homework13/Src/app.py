from flask import Flask, request, jsonify
import csv
import os

app = Flask(__name__)
CSV_FILE = 'students.csv'

def read_students():
    if not os.path.exists(CSV_FILE):
        return []
    with open(CSV_FILE, newline='') as csvfile:
        return list(csv.DictReader(csvfile))

def write_students(students):
    with open(CSV_FILE, 'w', newline='') as csvfile:
        fieldnames = ['id', 'first_name', 'last_name', 'age']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(students)

@app.route('/students', methods=['GET'])
def get_students():
    students = read_students()
    return jsonify(students), 200

@app.route('/students/<int:student_id>', methods=['GET'])
def get_student_by_id(student_id):
    students = read_students()
    for student in students:
        if int(student['id']) == student_id:
            return jsonify(student), 200
    return jsonify({'error': f'Student with id {student_id} not found'}), 404

@app.route('/students/search', methods=['GET'])
def get_student_by_last_name():
    last_name = request.args.get('last_name')
    students = read_students()
    matches = [s for s in students if s['last_name'].lower() == last_name.lower()]
    if matches:
        return jsonify(matches), 200
    return jsonify({'error': f'Student with last name {last_name} not found'}), 404

@app.route('/students', methods=['POST'])
def add_student():
    data = request.get_json()
    required_fields = ['first_name', 'last_name', 'age']
    if not data or not all(field in data for field in required_fields):
        return jsonify({'error': 'Missing one or more required fields'}), 400

    students = read_students()
    new_id = str(max([int(s['id']) for s in students], default=0) + 1)

    new_student = {
        'id': new_id,
        'first_name': data['first_name'],
        'last_name': data['last_name'],
        'age': str(data['age'])
    }

    students.append(new_student)
    write_students(students)
    return jsonify(new_student), 201

@app.route('/students/<int:student_id>', methods=['PATCH'])
def update_age(student_id):
    data = request.get_json()
    if 'age' not in data:
        return jsonify({'error': 'Missing age'}), 400

    students = read_students()
    for student in students:
        if int(student['id']) == student_id:
            student['age'] = str(data['age'])
            write_students(students)
            return jsonify(student), 200
    return jsonify({'error': f'Student with id {student_id} not found'}), 404

@app.route('/students/<int:student_id>', methods=['PUT'])
def update_student(student_id):
    data = request.get_json()
    required_fields = ['first_name', 'last_name', 'age']
    if not all(field in data for field in required_fields):
        return jsonify({'error': 'Missing required fields'}), 400

    students = read_students()
    for student in students:
        if int(student['id']) == student_id:
            student['first_name'] = data['first_name']
            student['last_name'] = data['last_name']
            student['age'] = str(data['age'])
            write_students(students)
            return jsonify(student), 200
    return jsonify({'error': f'Student with id {student_id} not found'}), 404

@app.route('/students/<int:student_id>', methods=['DELETE'])
def delete_student(student_id):
    students = read_students()
    updated_students = [s for s in students if int(s["id"]) != student_id]
    if len(updated_students) == len(students):
        return jsonify({"error": f"Student with id {student_id} not found"}), 404

    write_students(updated_students)
    return jsonify({"message": f"Student with id {student_id} deleted successfully"}), 200

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
