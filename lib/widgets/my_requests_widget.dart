import 'package:flutter/material.dart';
class MyRequestsWidget extends StatelessWidget {
  const MyRequestsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  8, vertical: 8),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.amber),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
        tileColor: Colors.grey.shade100,
        title: const Text("Jandarma" , style: TextStyle(
            fontWeight: FontWeight.bold
        ),),
        subtitle: const Text("tır yağmalanması"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ],
        ),

      ),
    );
  }
}
