import 'package:dw23_delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:dw23_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw23_delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dw23_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:dw23_delivery_app/app/pages/auth/login/login_controller.dart';
import 'package:dw23_delivery_app/app/pages/auth/login/login_state.dart';
import 'package:easy_comp/easy_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController(text: "borges.jvdo@gmail.com");
  final _passwordEC = TextEditingController(text: "lari2504");

  @override
  void dispose() {
    _passwordEC.dispose();
    _emailEC.dispose();

    super.dispose();
  }

  Future _handleLogin(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    await controller.login(_emailEC.text, _passwordEC.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
      listener: (_, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          login: () => showLoader(),
          success: () {
            hideLoader();
            showSuccess("Login realizado com sucesso");
            Navigator.pop(context, true);
          },
          error: () {
            hideLoader();
            showError("Erro ao tentar gazer login do usuário");
          },
          loginError: () {
            hideLoader();
            showError("E-mail ou senha inválidos");
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
                        "Login",
                        style: context.textApp.textTitle,
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
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) => _handleLogin(context),
                      ),
                      const SizedBox(height: 50),
                      Center(
                        child: DeliveryButton(
                          label: "ENTRAR",
                          width: double.infinity,
                          onTap: () {
                            _handleLogin(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Não possui uma conta",
                        style: context.textApp.textBold,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/auth/register");
                        },
                        child: Text(
                          "Cadastre-se",
                          style: context.textApp.textBold.copyWith(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}