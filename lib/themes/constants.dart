class Luvas {
  static const String email = 'E-mail';
  static const String password = 'Senha';
  static const String btSignIn = 'Login';
  static const String btSignUp = 'Cadastre-se';
  static const String btDemonstration = 'Demonstração';
  static const String noAccount = 'Não tem uma conta?';
  static const String consWatts = 'Consumo em Watts';
  static const String consHours = 'Horas de uso por dia';
  static const String username = 'Nome';
  static const String cpf = 'CPF';
  static const String btSigningUp = 'Cadastrar';
  static const String days = 'Dias';
  static const String conskW = 'Consumo (kWh)';
  static const String costRS = 'Custo R\$';
  static const String twentyDays = '20';
  static const String thirtyDays = '30';
  static const String yearDays = '365';
  static const String calculate = 'Calcular';
  static const String nameDevice = 'Nome';
  static const String powerDevice = 'Potência';
  static const String simulationCalc = 'Simular consumo';
  static const String registerDevice = 'Cadastrar dispositivo';
  static const String selectFlag = 'Selecionar uma bandeira:';
  static const String goBack = 'Voltar';
  static const String leave = 'Sair';
}

class Meias {
  static const String imges = 'assets/imges.png';
  static const String space = 'assets/space.png';
  static const String teste = 'assets/teste.png';
  static const List<String> flags = [
    'flag-green.png',
    'flag-yellow.png',
    'flag-red.png',
    'flag-black-red.png',
    'flag-black.png'
  ];
}

class Underwear {
  // static const String baseURL = 'http://25.72.151.164:8080/';
  static const String baseURL =
      'https://electrical-consumption.herokuapp.com/api/';
  // static const String baseURL = 'http://127.0.0.1:8000/api/';

  static const String loginURL = 'login';
  static const String registerURL = 'register';
  static const String logoutURL = 'logout';

  static const String getUserURL = 'show-user';
  static const String updateUserURL = 'update-user';
  static const String deleteUserURL = 'delete-user';

  static const String flagsURL = 'flags';

  static const String containersURL = 'containers';

  // static const String listContainersURL = 'container';
  // static const String getContainerURL = 'container'; // /{id}
  // static const String createContainerURL = 'container';
  // static const String saveContainerURL = 'container'; // /{id}
  // static const String deleteContainerURL = 'container'; // /{id}

  static const String deleteContainerDeviceURL = 'delete-container-device';
  // /{container_id}/{device_id}

  // static const String listDevicesURL = 'device/list?page=0';

  static const String devicesURL = 'devices';

  // static const String listDevicesURL = 'device';
  // static const String getDeviceURL = 'device'; // /{id}
  // static const String createDeviceURL = 'device';
  // static const String saveDeviceURL = 'device'; // /{id}
  // static const String deleteDeviceURL = 'device'; // /{id}

  static const String dicasURL =
      'https://www.grupocpfl.com.br/energias-sustentaveis/dicas-de-consumo-inteligente';
}
