class Validar {

  bool valida;

  Validar(){
    this.valida = false;
  }

  void esValida(){
    this.valida = true;
  }

  bool getLogin(){
    return this.valida;
  }
}