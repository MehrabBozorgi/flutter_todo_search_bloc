import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_cubit/cubit/cubit.dart';
import 'package:flutter_todo_cubit/model/todo_model.dart';

class SearchAndFilterTodoWidget extends StatelessWidget {
  const SearchAndFilterTodoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Search todo...',
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (String? newSearchTerm) {
            if (newSearchTerm != null) {
              context.read<TodoSearchCubit>().setSearchTerm(newSearchTerm);
            }
          },
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            FilterButton(filter: Filter.all),
            FilterButton(filter: Filter.active),
            FilterButton(filter: Filter.completed),
          ],
        ),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({Key? key, required this.filter}) : super(key: key);
  final Filter filter;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<TodoFilterCubit>().changeFilter(filter);
      },
      child: Text(
        filter == Filter.all
            ? 'All'
            : filter == Filter.completed
                ? 'Completed'
                : 'Active',
        style: TextStyle(
          fontSize: 18,
          color: textColor(context, filter),
        ),
      ),
    );
  }

  Color textColor(BuildContext context, Filter filter) {
    final currentFilter = context.watch<TodoFilterCubit>().state.filter;
    return currentFilter == filter ? Colors.blue : Colors.grey;
  }
}
