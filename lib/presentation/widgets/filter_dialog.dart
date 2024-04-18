import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/filter_params.dart';

class FilterDialog extends StatefulWidget {
  final FilterParams initialParams;

  const FilterDialog({super.key, required this.initialParams});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late TextEditingController _voteAverageGteController;
  late TextEditingController _voteCountGteController;
  late TextEditingController _releaseDateGteController;
  late TextEditingController _yearController;
  String? _sortBy;
  List<int>? _withGenres;

  @override
  void initState() {
    super.initState();
    _voteAverageGteController = TextEditingController(
        text: widget.initialParams.voteAverageGte?.toString());
    _voteCountGteController = TextEditingController(
        text: widget.initialParams.voteCountGte?.toString());
    _releaseDateGteController =
        TextEditingController(text: widget.initialParams.release_date_gte);
    _yearController =
        TextEditingController(text: widget.initialParams.year?.toString());
    _sortBy = widget.initialParams.sortBy;
    _withGenres = widget.initialParams.with_genres;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Parameters'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            DropdownButton<String>(
              borderRadius: BorderRadius.circular(8),
              isExpanded: true,
              value: _sortBy,
              items: <String>[
                'popularity.asc',
                'popularity.desc',
                'vote_average.asc',
                'vote_average.desc',
                'vote_count.asc',
                'vote_count.desc',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: const Text('Sort By'),
              onChanged: (String? newValue) {
                setState(() {
                  _sortBy = newValue;
                });
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _voteAverageGteController,
              decoration: const InputDecoration(labelText: 'Vote Average'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _voteCountGteController,
              decoration: const InputDecoration(labelText: 'Vote Count'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _releaseDateGteController,
              decoration: const InputDecoration(labelText: 'Release Date'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _yearController,
              decoration: const InputDecoration(labelText: 'Year'),
              keyboardType: TextInputType.number,
            ),
            // Add a field for _withGenres as needed
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Reset'),
          onPressed: () {
            setState(() {
              _voteAverageGteController.text = '';
              _voteCountGteController.text = '';
              _releaseDateGteController.text = '';
              _yearController.text = '';
              _sortBy = null;
              _withGenres = null;
            });
          },
        ),
        TextButton(
          child: const Text('Apply'),
          onPressed: () {
            final filterParams = FilterParams(
              sortBy: _sortBy,
              voteAverageGte: double.tryParse(_voteAverageGteController.text),
              voteCountGte: double.tryParse(_voteCountGteController.text),
              release_date_gte: _releaseDateGteController.text,
              vote_average_gte: double.tryParse(_voteAverageGteController.text),
              vote_count_gte: double.tryParse(_voteCountGteController.text),
              with_genres: _withGenres,
              year: int.tryParse(_yearController.text),
            );
            Navigator.of(context).pop(filterParams);
          },
        ),
      ],
    );
  }
}
