import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tests/transaction/transaction.dart';
import '../theme/theme_constants.dart';

class AddTransactionDialog extends StatefulWidget {
  final Function addTransaction;

  const AddTransactionDialog({super.key, required this.addTransaction});

  @override
  AddTransactionDialogState createState() => AddTransactionDialogState();
}

class AddTransactionDialogState extends State<AddTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isExpense = true;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String title = _titleController.text.trim();
      double amount = double.parse(_amountController.text.trim());
      Transaction transaction = Transaction(
        title: title,
        amount: amount,
        isExpense: _isExpense,
        date: DateTime.now(),
      );
      widget.addTransaction(transaction);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        'addtrans'.tr(),
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      content: Form(
          key: _formKey, //
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Neumorphic(
                style: NeumorphicStyle(
                  depth: -5,
                  intensity: 0.8,
                  shadowLightColor:
                      Theme.of(context).brightness == Brightness.light
                          ? const NeumorphicStyle().shadowLightColor
                          : Theme.of(context).shadowColor,
                  shadowDarkColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? const NeumorphicStyle().shadowDarkColor
                          : grey400,
                  color: Theme.of(context).brightness == Brightness.light
                      ? grey200
                      : grey800,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(12),
                  ),
                ),
                child: TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'entertitle'.tr();
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Neumorphic(
                style: NeumorphicStyle(
                  depth: -5,
                  intensity: 0.8,
                  shadowLightColor:
                      Theme.of(context).brightness == Brightness.light
                          ? const NeumorphicStyle().shadowLightColor
                          : Theme.of(context).shadowColor,
                  shadowDarkColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? const NeumorphicStyle().shadowDarkColor
                          : grey400,
                  color: Theme.of(context).brightness == Brightness.light
                      ? grey200
                      : grey800,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(12),
                  ),
                ),
                child: TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'amount'.tr(),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enteramount'.tr();
                    }
                    if (double.tryParse(value) == null) {
                      return 'entervalidnumber'.tr();
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  NeumorphicCheckbox(
                    style: NeumorphicCheckboxStyle(
                        selectedColor: Colors.lightGreen,
                        disabledColor:
                            Theme.of(context).brightness == Brightness.light
                                ? grey200
                                : grey800,
                        selectedDepth: -10,
                        unselectedDepth: 6),
                    value: _isExpense,
                    onChanged: (value) {
                      setState(() {
                        _isExpense = value!;
                      });
                    },
                  ),
                  const SizedBox(width: 9),
                  Text(
                    'expense'.tr(),
                  ),
                ],
              ),
            ],
          )),
      actions: [
        NeumorphicButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            intensity: 0.8,
            depth: 9,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(12),
            ),
            shadowLightColor: Theme.of(context).brightness == Brightness.light
                ? const NeumorphicStyle().shadowLightColor
                : Theme.of(context).shadowColor,
            shadowDarkColor: Theme.of(context).brightness == Brightness.dark
                ? const NeumorphicStyle().shadowDarkColor
                : grey400,
            color: Theme.of(context).brightness == Brightness.light
                ? grey200
                : grey800,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text(
            'cancel'.tr(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        NeumorphicButton(
          onPressed: _submitForm,
          style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            intensity: 0.8,
            depth: 9,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(12),
            ),
            shadowLightColor: Theme.of(context).brightness == Brightness.light
                ? const NeumorphicStyle().shadowLightColor
                : Theme.of(context).shadowColor,
            shadowDarkColor: Theme.of(context).brightness == Brightness.dark
                ? const NeumorphicStyle().shadowDarkColor
                : grey400,
            color: Theme.of(context).brightness == Brightness.light
                ? grey200
                : grey800,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text(
            'add'.tr(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
