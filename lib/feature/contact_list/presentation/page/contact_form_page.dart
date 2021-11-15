import 'package:contacts_app/core/widget/editable_avatar_widget.dart';
import 'package:contacts_app/core/widget/icon_avatar_widget.dart';
import 'package:contacts_app/core/widget/text_form_field_widget.dart';
import 'package:contacts_app/feature/contact_list/data/repository/contact_repository_impl.dart';
import 'package:contacts_app/feature/contact_list/domain/entity/contact.dart';
import 'package:contacts_app/feature/contact_list/presentation/bloc/contact_bloc.dart';
import 'package:contacts_app/feature/contact_list/presentation/bloc/contact_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class ContactFormPage extends StatefulWidget {
  const ContactFormPage(
      {Key? key, this.contact, this.contactIndex, this.contactId})
      : super(key: key);

  final Contact? contact;
  final int? contactIndex;
  final int? contactId;

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  String? _name;
  String? _mobile;
  String? _landline;
  String? _photoPath;
  bool _isFavorite = false;
  File? photo;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      _name = widget.contact!.name;
      _mobile = widget.contact!.mobile;
      _landline = widget.contact!.landline;
      _photoPath = widget.contact!.photo;
      _isFavorite = widget.contact!.isFavorite;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.contact != null ? 'Update Contact' : 'Add New Contact'),
        actions: <Widget>[
          if (widget.contact != null) _buildDelete(),
          _buildIsFavorite(),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildContactPhoto(context),
              const SizedBox(height: 24.0),
              TextFormFieldWidget(
                hintText: 'Name',
                icon: const Icon(Icons.person),
                initialValue: _name,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _name = value;
                },
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10.0),
              TextFormFieldWidget(
                hintText: 'Mobile',
                icon: const Icon(Icons.local_phone),
                initialValue: _mobile,
                validator: (String? value) {},
                onSaved: (String? value) {
                  _mobile = value;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10.0),
              TextFormFieldWidget(
                hintText: 'Landline',
                icon: const Icon(Icons.tty_rounded),
                initialValue: _landline,
                validator: (String? value) {},
                onSaved: (String? value) {
                  _landline = value;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10.0),
              widget.contact == null
                  ? _buildSaveButton(context)
                  : _buildUpdateButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIsFavorite() {
    return IconButton(
      icon: Icon(
        _isFavorite ? Icons.star : Icons.star_border,
        color: Colors.teal,
      ),
      onPressed: () {
        setState(() {
          _isFavorite = !_isFavorite;
        });
      },
    );
  }

  Widget _buildDelete() {
    return IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.teal,
      ),
      onPressed: () {
        setState(() {
          ContactRepositoryImpl.instance
              .deleteContact(widget.contact!.id!)
              .then((_) {
            BlocProvider.of<ContactBloc>(context).add(
              DeleteContact(widget.contactIndex!),
            );
            Navigator.pop(context);
          });
        });
      },
    );
  }

  _buildContactPhoto(BuildContext context) {
    return GestureDetector(
      child: _photoPath != null
          ? EditableAvatarWidget(
              imageFile: File(_photoPath!),
            )
          : Column(
              children: [
                photo != null
                    ? EditableAvatarWidget(
                        imageFile: photo!,
                      )
                    : const IconAvatarWidget(
                        avatarWidth: 120,
                        avatarHeight: 120,
                        iconData: Icons.add_a_photo,
                        iconSize: 64,
                      ),
              ],
            ),
      onTap: () {
        if (Platform.isAndroid) {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('Camera'),
                    onTap: () {
                      pickPhoto(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Browse in gallery'),
                    onTap: () {
                      pickPhoto(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        }
        if (Platform.isIOS) {
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) {
              return CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                    onPressed: () {
                      pickPhoto(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: const Text('Camera'),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      pickPhoto(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: const Text('Browse in gallery'),
                  )
                ],
              );
            },
          );
        }
      },
    );
  }

  Future pickPhoto(ImageSource source) async {
    try {
      final photo = await ImagePicker().pickImage(source: source);
      if (photo == null) return;

      final photoPermanent = await savePhotoPermanently(photo.path);
      setState(() {
        this.photo = photoPermanent;
        _photoPath = photo.path;
      });
    } on PlatformException catch (e) {
      print('Failed to pick photo: $e');
    }
  }

  Future<File> savePhotoPermanently(String photoPath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = path.basename(photoPath);
    final photo = File('${directory.path}/$name');

    return File(photoPath).copy(photo.path);
  }

  _buildSaveButton(BuildContext context) {
    return ElevatedButton(
      child: const Text(
        'SAVE',
        style: TextStyle(fontSize: 16.0, letterSpacing: 1.2),
      ),
      onPressed: () {
        if (photo != null) {
          savePhotoPermanently(photo!.path);
        }
        if (!_formKey.currentState!.validate()) {
          return;
        }
        _formKey.currentState!.save();

        Contact contact = Contact(
          name: _name,
          mobile: _mobile,
          landline: _landline,
          photo: _photoPath,
          isFavorite: _isFavorite,
        );

        ContactRepositoryImpl.instance.insertContact(contact).then(
              (storedContact) => BlocProvider.of<ContactBloc>(context).add(
                CreateContact(storedContact),
              ),
            );
        Navigator.pop(context);
      },
    );
  }

  _buildUpdateButton(BuildContext context) {
    return ElevatedButton(
      child: const Text(
        "UPDATE",
        style: TextStyle(fontSize: 16.0, letterSpacing: 1.2),
      ),
      onPressed: () {
        if (photo != null) {
          savePhotoPermanently(photo!.path);
        }

        if (!_formKey.currentState!.validate()) {
          return;
        }
        _formKey.currentState!.save();

        Contact contact = Contact(
          id: widget.contactId,
          name: _name,
          mobile: _mobile,
          landline: _landline,
          photo: _photoPath,
          isFavorite: _isFavorite,
        );

        ContactRepositoryImpl.instance.updateContact(contact).then(
              (storedContact) => BlocProvider.of<ContactBloc>(context).add(
                UpdateContact(widget.contactIndex!, contact),
              ),
            );
        Navigator.pop(context);
      },
    );
  }
}
