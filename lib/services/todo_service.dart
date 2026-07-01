import 'package:cloud_firestore/cloud_firestore.dart';

class TodoService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _todosCollection = _firestore.collection(
    'todos',
  );

  // TODO 1: CREATE - Add new todo to Firestore
  // Instructions:
  // 1. Use _todosCollection.add() to create a new document
  // 2. The document should have these fields:
  //    - 'task' (String): the todo text
  //    - 'completed' (boolean): false by default
  //    - 'timestamp': use FieldValue.serverTimestamp()
  // 3. Return the DocumentReference
  static Future<DocumentReference> addTodo(String task) async {
    // STUDENT IMPLEMENTATION AREA
    // Remove this exception and write your code here
    // throw Exception('Students: Implement addTodo function!');
    // Example structure:
    return await _todosCollection.add({
      'task': task,
      'completed': false,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // TODO 2: READ - Get todos stream for real-time updates
  // Instructions:
  // 1. Return a stream from _todosCollection
  // 2. Order by 'timestamp' in descending order
  // 3. Use .snapshots() for real-time updates
  static Stream<QuerySnapshot> getTodosStream() {
    // STUDENT IMPLEMENTATION AREA
    // Remove this exception and write your code here
    // throw Exception('Students: Implement getTodosStream function!');
    // Example structure:
    return _todosCollection.orderBy('timestamp', descending: true).snapshots();
  }

  // TODO 3: UPDATE - Toggle todo completion status
  // Instructions:
  // 1. Use _todosCollection.doc(id).update() to update specific document
  // 2. Update the 'completed' field to the opposite of currentStatus
  // 3. Also update 'updatedAt' timestamp
  static Future<void> toggleTodo(String id, bool currentStatus) async {
    // STUDENT IMPLEMENTATION AREA
    // Remove this exception and write your code here
    // throw Exception('Students: Implement toggleTodo function!');
    // Example structure:
    await _todosCollection.doc(id).update({
      'completed': !currentStatus,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // TODO 4: UPDATE - Edit todo text
  // Instructions:
  // 1. Use _todosCollection.doc(id).update() to update specific document
  // 2. Update the 'task' field with newTask
  // 3. Also update 'updatedAt' timestamp
  static Future<void> updateTodo(String id, String newTask) async {
    // STUDENT IMPLEMENTATION AREA
    // Remove this exception and write your code here
    // throw Exception('Students: Implement updateTodo function!');
    // Example structure:
    await _todosCollection.doc(id).update({
      'task': newTask,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // TODO 5: DELETE - Remove a todo
  // Instructions:
  // 1. Use _todosCollection.doc(id).delete() to remove the document
  static Future<void> deleteTodo(String id) async {
    // STUDENT IMPLEMENTATION AREA
    // Remove this exception and write your code here
    // throw Exception('Students: Implement deleteTodo function!');
    // Example structure:
    await _todosCollection.doc(id).delete();
  }

  // TODO 6: BONUS - Delete all completed todos
  // Instructions:
  // 1. Query todos where 'completed' is true
  // 2. Use a batch to delete all matching documents
  static Future<void> deleteCompletedTodos() async {
    // STUDENT IMPLEMENTATION AREA
    // Remove this exception and write your code here
    //throw Exception('Students: Implement deleteCompletedTodos function!');
    // Example structure:
    final querySnapshot = await _todosCollection
        .where('completed', isEqualTo: true)
        .get();

    final batch = _firestore.batch();
    for (final doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
