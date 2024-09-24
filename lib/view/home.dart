import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:commentme/providers/auth_provider.dart';
import 'package:commentme/providers/user_provider.dart';
import 'package:commentme/providers/comment_provider.dart';
import 'package:commentme/routes.dart';

import '../model/comment.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = _initializeData();
  }

  Future<void> _initializeData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final commentProvider = Provider.of<CommentProvider>(context, listen: false);

    if (authProvider.user != null) {
      await userProvider.fetchUser(authProvider.user!.uid);
    }
    await commentProvider.fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final commentProvider = Provider.of<CommentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await authProvider.signOut();
              Navigator.of(context).pushReplacementNamed(AppRouter.login);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (userProvider.user == null) {
            return const Center(child: Text('User data not available'));
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _buildUserProfile(userProvider),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Comments',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              commentProvider.isLoading
                  ? const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _buildCommentCard(commentProvider.comments[index]),
                        childCount: commentProvider.comments.length,
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUserProfile(UserProvider userProvider) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue,
              child: Text(
                userProvider.user!.name![0].toUpperCase(),
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userProvider.user!.name!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userProvider.user!.email ?? 'N/A',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentCard(Comment comment) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          child: Text(comment.name[0].toUpperCase()),
        ),
        title: Text(comment.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(comment.email),
            const SizedBox(height: 4),
            Text(
              comment.body.length > 50 ? '${comment.body.substring(0, 50)}...' : comment.body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}