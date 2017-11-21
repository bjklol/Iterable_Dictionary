# EECS_3311_Lab5

This project contains files used for the iterable dictionary in lab 5

Problem
The dictionary ADT (Abstract Data Type) supports the storage and access of a collection of entries. Each
entry is characterized by a search key and its associated value. It is necessary that keys are not duplicated,
so that each key can uniquely identify an associated value. On the other hand, different keys may map to
different values.
In this lab exercise, you are required to extend the previous exercise, on the iterable dictionary ADT, by
creating an abstraction function for it: given a dictionary instance d, define a query model which converts
d into a mathematical function (supported by the mathmodels library made available to you), and use this
mathematical model function to write all contracts.
Here are stringent requirements for this lab exercise:
– You are allowed to use any parts of only your own code developed from the previous lab exercise.
– Once the query model is defined in the DICTIONARY class, no contracts (preconditions, postconditions,
invariants) can contain any occurrence of the private attributes (e.g., keys, values). If any occurrence
of using the private attributes is found in your contracts, rather than just using the model query
(or Result if applicable), then you receive an immediate zero for the programming part of this lab
exercise.
4.1 Programming
4.1.1 Getting Started
– Download the starter project archive Lab 5.zip from the course moodle, unzip it, and launch EStudio.
– Choose Add Project, browse to the project configuration file Lab 5/dictionary math/dictionary.ecf,
then select Open.
– It is expected that the starter project does not compile. This is because there are definitions of
command/query bodies.
– Study carefully the INSTRUCTOR DICTIONARY TESTS class, where test cases are provided to illustrate
how the various features are expected for you to implement.
– This is the suggested workflow for you:
• You are forbidden to create any new classes and to create any new features in the DICTIONARY
class.
• You should start by adding the necessary body implementations for features in order to at least
make the entire project compile. You receive 0 marks if your submitted project does not compile.
• Then, add your own tests until you are satisfied before submission.
Any test classes that you add must be created under the tests/student cluster.
4.1.2 Tasks
– A generic class DICTIONARY[V -> attached ANY, K -> attached ANY] is already declared for you,
where V and K denotes types of, respectively, the values and their search keys. In this lab you will be
using the mathmodels library, where all generic parameters are required to be attached for void safety,
and this is why you see the constrained genericity when declaring the DICTIONARY class.
– Notice that in Eiffel collection classes such as ARRAY, LINKED LIST, and TUPLE:
• There is a Boolean attribute object comparison, which indicates if items in the collections are
to be compared using reference equality (i.e., via = when object comparison is false) or object
equality (i.e., via the user-redefined is equal feature when object comparison is true).
4
• By default, the object comparison attribute is false. If you mean it to be true, you can call
the command compare objects.
• See the test array comarison feature in class INSTRUCTOR DICTIONARY TESTS for an example.
– For this lab exercise, you are forced to implement the dictionary ADT via a naive solution using two
linear data structures: an array of values and a linked list of keys. A value (from the values array) and
a key (from the keys list), given that both are at the same index, make an entry in the dictionary.
– You are forbidden to use any other library class such as HASH TABLE to implement the dictionary. Such
a constraint is imposed to make you practice the “unlucky” case of implementing the Iterator Pattern.
– You are required to make the DICTIONARY class iterable.
– Then, identify all -- Your Task comments which indicate what you should complete.
– Comments within the DICTIONARY class, together with the test queries in INSTRUCTOR DICTIONARY TESTS,
should provide you with information to complete all the programming tasks.
Where contracts are expected to be written, you are forbidden to use the private attributes (keys,
values); instead, you are only supposed to use the model query (and Result if applicable) to complete
your contracts. Any violations of this rule will result in an immediate zero of the programming part
of this lab.
