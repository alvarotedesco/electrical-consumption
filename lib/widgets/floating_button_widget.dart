import 'package:flutter/material.dart';

class FloatingCustomButtonWidget extends StatefulWidget {
  VoidCallback? onConfirmButton;
  VoidCallback? onCancelButton;
  VoidCallback? onDeleteButton;
  VoidCallback? onEditButton;
  VoidCallback? onNewButton;

  final bool cancel;
  final bool selected;

  FloatingCustomButtonWidget({
    required this.selected,
    this.cancel = false,
    this.onConfirmButton,
    this.onCancelButton,
    this.onDeleteButton,
    this.onEditButton,
    this.onNewButton,
    super.key,
  });

  @override
  State<FloatingCustomButtonWidget> createState() =>
      _FloatingCustomButtonWidgetState();
}

class _FloatingCustomButtonWidgetState
    extends State<FloatingCustomButtonWidget> {
  @override
  void initState() {
    super.initState();

    widget.onEditButton ??= () {};
    widget.onNewButton ??= () {};
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (!widget.cancel) ...[
          if (widget.selected) ...[
            FloatingActionButton(
              tooltip: "Editar",
              onPressed: widget.onEditButton,
              child: Icon(
                Icons.edit,
                size: 40,
              ),
            ),
            SizedBox(height: 20),
            FloatingActionButton(
              tooltip: "Excluir",
              onPressed: widget.onDeleteButton,
              child: Icon(
                Icons.delete_forever,
                size: 40,
              ),
            ),
          ] else
            FloatingActionButton(
              tooltip: "Novo",
              onPressed: widget.onNewButton,
              child: Icon(
                Icons.add,
                size: 40,
              ),
            ),
        ] else ...[
          FloatingActionButton(
            tooltip: 'Confirmar',
            onPressed: widget.onConfirmButton,
            child: Icon(
              Icons.check,
              size: 40,
            ),
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            tooltip: 'Cancelar',
            onPressed: widget.onCancelButton,
            child: Icon(
              Icons.clear,
              size: 40,
            ),
          ),
        ],
      ],
    );
  }
}
