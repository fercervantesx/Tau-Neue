import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Basic Form',
  type: TauFormLayout,
)
Widget basicTauFormLayout(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauFormLayout(
      fields: [
        TauFormField(
          label: 'USERNAME',
          isRequired: true,
          child: TauInput(
            placeholder: 'Enter username',
          ),
        ),
        TauFormField(
          label: 'EMAIL',
          isRequired: true,
          child: TauInput(
            placeholder: 'Enter email address',
          ),
        ),
        TauFormField(
          label: 'PASSWORD',
          isRequired: true,
          helperText: 'Minimum 8 characters required',
          child: TauInput(
            placeholder: 'Enter password',
            obscureText: true,
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Validation',
  type: TauFormLayout,
)
Widget validationTauFormLayout(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauFormLayout(
      fields: [
        TauFormField(
          label: 'USERNAME',
          isRequired: true,
          errorText: 'Username is required',
          child: TauInput(
            placeholder: 'Enter username',
          ),
        ),
        TauFormField(
          label: 'EMAIL',
          isRequired: true,
          errorText: 'Invalid email format',
          child: TauInput(
            placeholder: 'Enter email address',
          ),
        ),
        TauFormField(
          label: 'PASSWORD',
          isRequired: true,
          helperText: 'Password meets requirements',
          child: TauInput(
            placeholder: 'Enter password',
            obscureText: true,
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Mixed Controls',
  type: TauFormLayout,
)
Widget mixedTauFormLayout(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauFormLayout(
      fields: [
        TauFormField(
          label: 'OPERATOR NAME',
          isRequired: true,
          child: TauInput(
            placeholder: 'Enter name',
          ),
        ),
        TauFormField(
          label: 'SECURITY CLEARANCE',
          isRequired: true,
          child: TauSelect<String>(
            value: 'classified',
            options: const [
              TauSelectOption(value: 'public', label: 'PUBLIC'),
              TauSelectOption(value: 'confidential', label: 'CONFIDENTIAL'),
              TauSelectOption(value: 'secret', label: 'SECRET'),
              TauSelectOption(value: 'classified', label: 'CLASSIFIED'),
            ],
            onChanged: (value) {},
          ),
        ),
        TauFormField(
          label: 'ENCRYPTION ENABLED',
          child: TauToggle(
            value: true,
            onChanged: (value) {},
          ),
        ),
        TauFormField(
          label: 'MISSION BRIEFING',
          helperText: 'Max 500 characters',
          child: TauInput.textarea(
            placeholder: 'Enter mission details',
            minLines: 3,
            maxLines: 5,
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Form Group',
  type: TauFormGroup,
)
Widget groupTauFormLayout(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TauFormGroup(
          title: 'PERSONAL INFORMATION',
          fields: [
            TauFormField(
              label: 'FIRST NAME',
              isRequired: true,
              child: TauInput(
                placeholder: 'Enter first name',
              ),
            ),
            TauFormField(
              label: 'LAST NAME',
              isRequired: true,
              child: TauInput(
                placeholder: 'Enter last name',
              ),
            ),
            TauFormField(
              label: 'RANK',
              child: TauSelect<String>(
                value: 'captain',
                options: const [
                  TauSelectOption(value: 'private', label: 'PRIVATE'),
                  TauSelectOption(value: 'sergeant', label: 'SERGEANT'),
                  TauSelectOption(value: 'lieutenant', label: 'LIEUTENANT'),
                  TauSelectOption(value: 'captain', label: 'CAPTAIN'),
                  TauSelectOption(value: 'major', label: 'MAJOR'),
                ],
                onChanged: (value) {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 32.0),
        TauFormGroup(
          title: 'SECURITY SETTINGS',
          fields: [
            TauFormField(
              label: 'ACCESS CODE',
              isRequired: true,
              helperText: '8-digit numeric code',
              child: TauInput(
                placeholder: 'Enter access code',
                obscureText: true,
              ),
            ),
            TauFormField(
              label: 'TWO-FACTOR AUTH',
              child: TauToggle(
                value: true,
                label: 'ENABLED',
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive',
  type: TauFormLayout,
)
Widget interactiveTauFormLayout(BuildContext context) {
  return _InteractiveTauFormLayoutDemo();
}

class _InteractiveTauFormLayoutDemo extends StatefulWidget {
  @override
  State<_InteractiveTauFormLayoutDemo> createState() =>
      _InteractiveTauFormLayoutDemoState();
}

class _InteractiveTauFormLayoutDemoState
    extends State<_InteractiveTauFormLayoutDemo> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  String? _securityLevel = 'medium';
  bool _notifications = true;

  String? _usernameError;
  String? _emailError;

  void _validateUsername(String value) {
    setState(() {
      if (value.isEmpty) {
        _usernameError = 'Username is required';
      } else if (value.length < 3) {
        _usernameError = 'Username must be at least 3 characters';
      } else {
        _usernameError = null;
      }
    });
  }

  void _validateEmail(String value) {
    setState(() {
      if (value.isEmpty) {
        _emailError = 'Email is required';
      } else if (!value.contains('@')) {
        _emailError = 'Invalid email format';
      } else {
        _emailError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: TauFormLayout(
        fields: [
          TauFormField(
            label: 'USERNAME',
            isRequired: true,
            errorText: _usernameError,
            child: TauInput(
              controller: _usernameController,
              placeholder: 'Enter username',
              onChanged: _validateUsername,
            ),
          ),
          TauFormField(
            label: 'EMAIL',
            isRequired: true,
            errorText: _emailError,
            child: TauInput(
              controller: _emailController,
              placeholder: 'Enter email address',
              onChanged: _validateEmail,
            ),
          ),
          TauFormField(
            label: 'SECURITY LEVEL',
            isRequired: true,
            child: TauSelect<String>(
              value: _securityLevel,
              options: const [
                TauSelectOption(value: 'low', label: 'LOW'),
                TauSelectOption(value: 'medium', label: 'MEDIUM'),
                TauSelectOption(value: 'high', label: 'HIGH'),
              ],
              onChanged: (value) => setState(() => _securityLevel = value),
            ),
          ),
          TauFormField(
            label: 'PUSH NOTIFICATIONS',
            child: TauToggle(
              value: _notifications,
              onChanged: (value) => setState(() => _notifications = value),
            ),
          ),
        ],
      ),
    );
  }
}
