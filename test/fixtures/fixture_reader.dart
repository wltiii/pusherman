import 'dart:convert';
import 'dart:io';

String fixtureAsString(String name) => Directory.current.path.endsWith('/test')
    ? File('fixtures/$name').readAsStringSync()
    : File('test/fixtures/$name').readAsStringSync();

Map<String, dynamic> fixtureAsMap(String name) => json.decode(fixtureAsString(name));