# Sample for Do iOS 2023
This is a sample app for a talk on SwiftData at Do iOS 2023 in Amsterdam.

The app is not fully functional, but does show how to model entities and relationships, including images, with SwiftData.

# Single Device
There are two basic models included. If you are just interested in a model that works on a single device, the 
manualmigration_nocloudkit branch is the best to look at. It includes a custom migration, which is not
possible with CloudKit.

# Multiple Device
If you want to use CloudKit sync, you can use the main branch. The model for that is more restricted due to
the requirements of CloudKit. For example, all relationships are optional. It also includes code to deduplicate
objects.
