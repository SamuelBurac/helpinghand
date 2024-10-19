import 'package:flutter_test/flutter_test.dart';
import 'package:project_name/hello_world.dart';

void main() {
  test('Test hello world functionality', () {
    // Arrange
    HelloWorld helloWorld = HelloWorld();

    // Act
    String result = helloWorld.sayHello();

    // Assert
    expect(result, 'Hello, World!');
  });
}