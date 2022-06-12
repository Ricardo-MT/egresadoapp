import 'package:egresadoapp/api/endpoints/api_usuario.dart';
import 'package:egresadoapp/api/models/user.dart';
import 'package:egresadoapp/providers/user_provider.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/loading.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/utils/validators.dart';
import 'package:egresadoapp/widgets/bring_in_widgets/fade_in_wrapper.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:egresadoapp/widgets/layout/screen.dart';
import 'package:egresadoapp/widgets/muiselect/muiselect.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:egresadoapp/widgets/tupla/tupla.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsuarioEditarRol extends StatefulWidget {
  final User original;
  const UsuarioEditarRol({Key? key, required this.original}) : super(key: key);

  @override
  State<UsuarioEditarRol> createState() => _UsuarioEditarState();
}

class _UsuarioEditarState extends State<UsuarioEditarRol> {
  @override
  Widget build(BuildContext context) {
    return MuiScreen(
      child: Consumer<UsuarioProvider>(
        builder: (context, provider, child) {
          User usuario = User.fromCopy(widget.original);

          return FadeInWrapper(
              index: 2,
              child: _UsuarioEditar(
                usuario: usuario,
              ));
        },
      ),
    );
  }
}

class _UsuarioEditar extends StatefulWidget {
  final User usuario;
  const _UsuarioEditar({Key? key, required this.usuario}) : super(key: key);

  @override
  State<_UsuarioEditar> createState() => __UsuarioEditar();
}

class __UsuarioEditar extends State<_UsuarioEditar> {
  late final _formKey;
  late User edited;
  late TextEditingController rolController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    edited = User.fromCopy(widget.usuario);
    rolController = TextEditingController(text: edited.estado);
  }

  void nextState() {
    setState(() {});
  }

  Future<void> handleSave() async {
    if (_formKey.currentState!.validate()) {
      edited.rol = rolController.value.text;
      LoadingHandler.showLoading(context);
      String? target;
      try {
        User newUser = await ApiUsuario.editRol(edited);
        target = newUser.id;
      } catch (e) {}
      LoadingHandler.hideLoading(context);

      if (target != null) {
        Navigator.of(context).pushNamed(NavigatorRoutes.userProfile(target));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MuiDataScreen(
        pageTitle: "Editando rol de usuario",
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Icon(
                  Icons.account_circle_rounded,
                  size: 200,
                  color: MuiPalette.BROWN,
                ),
              ),
              Center(child: RolTag(rol: edited.rol)),
              MuiSelect(
                label: "Rol",
                transformer: getLabelByRol,
                validator: Validators.validateIsEmpty,
                hint: "Egresad@, Colaborador ...",
                values: listaRoles,
                value: edited.rol,
                onChanged: (v) {
                  if (v != null) {
                    rolController.text = v;
                  }
                },
              ),
              spacerXL,
              MuiButton(onPressed: handleSave, text: "Guardar los cambios"),
              spacerXL,
            ],
          ),
        ));
  }
}
