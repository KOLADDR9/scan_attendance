import 'package:flutter/material.dart';
import '../../core/services/supabase_service1.dart';
import '../../presentation/pages/home_page.dart';

class MembersPage extends StatelessWidget {
  final SupabaseService supabaseService = SupabaseService();

  MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color.fromRGBO(16, 51, 50, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(16, 51, 50, 1),
              Color.fromRGBO(11, 32, 33, 1),
              Color.fromRGBO(5, 12, 14, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: supabaseService.fetchMembers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.white)));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('No members found.',
                      style: TextStyle(color: Colors.white)));
            } else {
              final members = snapshot.data!;
              return ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal.shade300,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(member['username'],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(member['email']),
                      trailing: Chip(
                        label: Text(member['position'],
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.teal.shade600,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
