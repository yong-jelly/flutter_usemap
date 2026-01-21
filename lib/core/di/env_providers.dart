import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Supabase URL Provider
final supabaseUrlProvider = Provider<String>((ref) {
  return 'https://xyqpggpilgcdsawuvpzn.supabase.co';
});

/// Supabase Anon Key Provider
final supabaseAnonKeyProvider = Provider<String>((ref) {
  return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh5cXBnZ3BpbGdjZHNhd3V2cHpuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY5NzY4MDAsImV4cCI6MjA1MjU1MjgwMH0.YourAnonKeyHere';
});
