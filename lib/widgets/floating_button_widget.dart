import 'package:flutter/material.dart';

class FloatingCustomButtonWidget extends StatefulWidget {
  VoidCallback? onConfirmButton;
  VoidCallback? onCancelButton;
  VoidCallback? onDeleteButton;
  VoidCallback? onEditButton;
  VoidCallback? onNewButton;

  String? heroTagEdit;
  String? heroTagConfirm;
  String? heroTagDelete;
  String? heroTagCancel;
  String? heroTagNew;

  final bool cancel;
  final bool selected;
  final bool newButton;

  FloatingCustomButtonWidget({
    required this.selected,
    this.newButton = true,
    this.cancel = false,
    this.onConfirmButton,
    this.onCancelButton,
    this.onDeleteButton,
    this.onEditButton,
    this.onNewButton,
    this.heroTagConfirm,
    this.heroTagCancel,
    this.heroTagDelete,
    this.heroTagEdit,
    this.heroTagNew,
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
              heroTag: widget.heroTagEdit,
              tooltip: "Editar",
              onPressed: widget.onEditButton,
              child: Icon(
                Icons.edit,
                size: 40,
              ),
            ),
            SizedBox(height: 20),
            FloatingActionButton(
              heroTag: widget.heroTagDelete,
              tooltip: "Excluir",
              onPressed: widget.onDeleteButton,
              child: Icon(
                Icons.delete_forever,
                size: 40,
              ),
            ),
          ],
          if (widget.newButton)
            FloatingActionButton(
              heroTag: widget.heroTagNew,
              tooltip: "Novo",
              onPressed: widget.onNewButton,
              child: Icon(
                Icons.add,
                size: 40,
              ),
            ),
        ] else ...[
          FloatingActionButton(
            heroTag: widget.heroTagConfirm,
            tooltip: 'Confirmar',
            onPressed: widget.onConfirmButton,
            child: Icon(
              Icons.check,
              size: 40,
            ),
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            heroTag: widget.heroTagCancel,
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
