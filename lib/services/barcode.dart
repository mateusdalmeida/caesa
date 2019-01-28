class BarCode{

  geraCodigo(tipoRetorno, valorPagar1, matricula1, mesReferencia1, origem1){
    var banco = '826';
    var dvGeral;
    var valorPagar = valorPagar1.toFixed(2).toString();
    var empresa = '00070';
    var matricula = matricula1.toString();
    var mesReferencia = mesReferencia1.toString();
    var origem = origem1.toString();
    var campoLivre = '0000000001';
    var dv1;
    var dv2;
    var dv3;
    var dv4;

    matricula.padLeft(6, '0');

    valorPagar = valorPagar.replaceAll('.', '');

    valorPagar.padLeft(11, '0');

    var calculoDvGeral = banco + valorPagar + empresa + matricula + mesReferencia + origem + campoLivre;
    dvGeral = this.calculaDigitoMod10(calculoDvGeral);

    var parte1 = calculoDvGeral.substring(0, 3);
    var parte2 = calculoDvGeral.substring(3, 43);
    var codigoSemDv = parte1 + dvGeral + parte2;

    var sub1 = codigoSemDv.substring(0, 11);
    dv1 = this.calculaDigitoMod10(sub1);
    var sub2 = codigoSemDv.substring(11, 22);
    dv2 = this.calculaDigitoMod10(sub2);
    var sub3 = codigoSemDv.substring(22, 33);
    dv3 = this.calculaDigitoMod10(sub3);
    var sub4 = codigoSemDv.substring(33, 44);
    dv4 = this.calculaDigitoMod10(sub4);
    
    if (tipoRetorno == 'copia'){
      var codigoCompvaroCopia = "$sub1$dv1$sub2$dv2$sub3$dv3$sub4$dv4";
      // this.clipboard.copy(codigoCompvaroCopia);
      // var toast = this.toastCtrl.create({
      //   message: 'Código copiado com sucesso',
      //   duration: 3000
      // })
      // toast.present()
      print(codigoCompvaroCopia);
      return "$sub1$dv1$sub2$dv2$sub3$dv3$sub4$dv4";
    }else if (tipoRetorno == 'bovaro'){
      return "$sub1-$dv1 $sub2-$dv2 $sub3-$dv3 $sub4-$dv4";
    }else if (tipoRetorno == 'barcode'){
      return "$sub1$sub2$sub3$sub4";
    }
  }

  calculaDigitoMod10(String dado){
    var i;
    var mult = 2;
    var soma = 0;
    var s = "";

    for (i=dado.length-1; i>=0; i--)
      {
      s = (mult * int.parse(dado[i])).toString() + s;
      if (--mult<1)
        {
        mult = 2;
        }
      }
    for (i=0; i<s.length; i++)
      {
      soma = soma + int.parse(s[i]);
      }
    soma = soma % 10;
    if (soma != 0)
      {
      soma = 10 - soma;
      }
    return soma.toString();
  }


}