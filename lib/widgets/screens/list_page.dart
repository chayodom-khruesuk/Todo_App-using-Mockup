import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lasttime/bloc/bloc.dart';
import 'package:flutter_lasttime/bloc/bloc_event.dart';
import 'package:flutter_lasttime/bloc/bloc_state.dart';

Expanded listPage() {
  return Expanded(
    child: BlocBuilder<LastTimeBloc, BlocState>(
      builder: (context, state) {
        final item = state.item;
        return item.isEmpty
            ? const Center(
                child: Text(
                  'No item found',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 20,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 77, 76, 76),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: BlocBuilder<LastTimeBloc, BlocState>(
                          builder: (context, state) {
                        if (state is ReadyState || state is SearchState) {
                          if (item[index].action == null) {
                            return ListTile(
                              title: Text(
                                item[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              trailing: const Text(
                                '',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          } else {
                            return ListTile(
                              title: Text(
                                item[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              trailing: Text(
                                item[index].action.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                context.read<LastTimeBloc>().add(
                                      RemoveEvent(item[index].id),
                                    );
                              },
                            );
                          }
                        } else if (state is RemoveState) {
                          return ListTile(
                              title: Text(
                                item[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onTap: () {
                                context
                                    .read<LastTimeBloc>()
                                    .add(RemoveEvent(item[index].id));
                              });
                        } else {
                          return const Material();
                        }
                      }),
                    ),
                  );
                },
              );
      },
    ),
  );
}
