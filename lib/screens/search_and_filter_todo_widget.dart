import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/todo_filter/todo_filter_bloc.dart';
import '../blocs/todo_search/todo_search_bloc.dart';
import '../model/todo_model.dart';
import '../utils/debounce.dart';

class SearchAndFilterTodoWidget extends StatelessWidget {
  SearchAndFilterTodoWidget({Key? key}) : super(key: key);
  final debounce = Debounce(millisecond: 1000);

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
          onChanged: (String? newSearchTerms) {
            if (newSearchTerms != null) {
              context
                  .read<TodoSearchBloc>()
                  .add(SetSearchTermEvent(newSearchTerms: newSearchTerms));
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
        context
            .read<TodoFilterBloc>()
            .add(ChangeFilterEvent(newFilter: filter));
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
    final currentFilter = context.watch<TodoFilterBloc>().state.filter;
    return currentFilter == filter ? Colors.blue : Colors.grey;
  }
}
