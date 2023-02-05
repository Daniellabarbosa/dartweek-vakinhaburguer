import 'package:dw23_delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:dw23_delivery_app/app/core/ui/styles/text_app.dart';
import 'package:dw23_delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dw23_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:dw23_delivery_app/app/pages/auth/register/register_controller.dart';
import 'package:dw23_delivery_app/app/pages/auth/register/register_state.dart';
import 'package:easy_comp/easy_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResgisterPage extends StatefulWidget {
  const ResgisterPage({Key? key}) : super(key: key);
  @override
  State<ResgisterPage> createState() => _ResgisterPageState();
}

class _ResgisterPageState extends BaseState<ResgisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _passwordEC.dispose();
    _emailEC.dispose();

    super.dispose();
  }

  Future _handleRegister(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    await controller.register(_nameEC.text, _emailEC.text, _passwordEC.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (_, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          register: () => showLoader(),
          success: () {
            hideLoader();
            showSuccess("Registro realizado com sucesso");
            Navigator.pop(context);
          },
          error: () {
            hideLoader();
            showError("Erro ao registra usuário");
          },
        );
      },
      child: Scaffold(
        appBar: DeliveryAppbar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cadastro",
                        style: context.textApp.textTitle,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Preencha os campos abaixo para criar o \nseu cadastro",
                        style: context.textApp.textTitle.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Nome*"),
                        validator: ValidatorUtil().required().build(),
                        controller: _nameEC,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: const InputDecoration(labelText: "E-mail*"),
                        validator: ValidatorUtil().required().email().build(),
                        controller: _emailEC,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Senha*"),
                        validator: ValidatorUtil().required().minLength(6, "Senha deve contar pelomenos 6 caracteres").build(),
                        controller: _passwordEC,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Confirmar senha*",
                          // suffixIcon: IconButton(
                          //   onPressed: () => mostraSenha.value = !mostraSenha.value,
                          //   icon: Icon(Icons.yo),
                          // ),
                        ),
                        validator: ValidatorUtil()
                            .required()
                            .minLength(6, "Senha deve contar pelomenos 6 caracteres")
                            .custom(
                              valide: (p0) => p0 != _passwordEC.text,
                              message: "Confirma senha deve ser igual a senha",
                            )
                            .build(),
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        onFieldSubmitted: (value) => _handleRegister(context),
                      ),
                      const SizedBox(height: 50),
                      Center(
                        child: DeliveryButton(
                          label: "CADASTRAR",
                          width: double.infinity,
                          onTap: () {
                            _handleRegister(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}