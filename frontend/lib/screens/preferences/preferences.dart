import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/blocs/preferences/prefrences_bloc.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/widgets.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              BooperHeader(
                child: Text(
                  "Prefrences",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.inverseTextColor,
                      ),
                ),
              ),
              PreferenceForm()
            ],
          ),
        ),
      ),
    );
  }
}

class PreferenceForm extends StatelessWidget {
  static final GlobalKey<FormBuilderState> form = GlobalKey<FormBuilderState>();

  PreferenceForm({super.key});

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height * 0.52;
    final prefrencesBloc = BlocProvider.of<PrefrencesBloc>(context);

    return FormBuilder(
      key: form,
      initialValue: prefrencesBloc.state.toJson(),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormBuilderTextField(
              name: 'cuisines',
              decoration: BooperInputDecoration(context).copyWith(
                labelText: 'Cuisines',
                hintText: 'Plate from where ?',
              ),
              validator: FormBuilderValidators.required(
                errorText: "No plates ?",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Divider(
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            FormBuilderTextField(
              name: 'cost',
              keyboardType: TextInputType.number,
              decoration: BooperInputDecoration(context).copyWith(
                labelText: 'Cost',
                hintText: 'How much per meal',
              ),
              validator: FormBuilderValidators.required(
                errorText: "Nothing is free in this world",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'carbs',
                      keyboardType: TextInputType.number,
                      decoration: BooperInputDecoration(context).copyWith(
                        labelText: 'Carbs',
                        hintText: 'How much per meal',
                      ),
                      validator: FormBuilderValidators.required(
                        errorText: "Nothing is free in this world",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'fats',
                      keyboardType: TextInputType.number,
                      decoration: BooperInputDecoration(context).copyWith(
                        labelText: 'fats',
                        hintText: 'How much per meal',
                      ),
                      validator: FormBuilderValidators.required(
                        errorText: "Nothing is free in this world",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'proteins',
                      keyboardType: TextInputType.number,
                      decoration: BooperInputDecoration(context).copyWith(
                        labelText: 'Protein',
                        hintText: 'How much per meal',
                      ),
                      validator: FormBuilderValidators.required(
                        errorText: "Nothing is free in this world",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'calories',
                      keyboardType: TextInputType.number,
                      decoration: BooperInputDecoration(context).copyWith(
                        labelText: 'Calories',
                        hintText: 'How much per meal',
                      ),
                      validator: FormBuilderValidators.required(
                        errorText: "Nothing is free in this world",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (form.currentState!.saveAndValidate()) {
                  final value = form.currentState!.value;
                  prefrencesBloc.add(PEUpdate(PrefrencesState.fromJson(value)));
                }
              },
              icon: const Icon(Icons.save),
              style: BooperPrimaryButton(context),
              label: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
