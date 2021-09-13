import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_wallet/providers/register_user/bloc/register_user_bloc.dart';

void main() {
  RegisterUserBloc registerUserBloc = RegisterUserBloc();

  test('Email Test.', () {
    expect(registerUserBloc.isEmailValid(''), false);
    expect(registerUserBloc.isEmailValid('asimk'), false);
    expect(registerUserBloc.isEmailValid('123'), false);
    expect(registerUserBloc.isEmailValid('test@example.com'), true);
  });

  test('Password Test.', () {
    expect(registerUserBloc.isPasswordValid(''), false);
    expect(registerUserBloc.isPasswordValid('12345'), false);
    expect(registerUserBloc.isPasswordValid('aa@2222L'), true);
    //expect(registerUserBloc.isPasswordValid('test@example.com'), true);
  });

  test('Birth Date Test.', () {
    expect(registerUserBloc.isDOBValid(''), false);
    expect(registerUserBloc.isDOBValid('22/2/1893'), false);
    expect(registerUserBloc.isDOBValid('22/2/2012'), false);
    expect(registerUserBloc.isDOBValid('22/2/2000'), true);
  });

  test('Country Test.', () {
    expect(registerUserBloc.isCountryNameValid(''), false);
    expect(registerUserBloc.isCountryNameValid('BO'), false);
    expect(registerUserBloc.isCountryNameValid('United Arab Emirates'), true);
  });
}
