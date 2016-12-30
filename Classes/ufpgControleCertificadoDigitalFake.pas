unit ufpgControleCertificadoDigitalFake;

interface

uses
  ufpgControleCertificadoDigital, Windows, Forms, SysUtils;

type
  TfpgControleCertificadoDigitalFake = class(TfpgControleCertificadoDigital)
  protected
    function PegarCPFCertificado(pnIdCertificado: integer): string; override;
  end;

implementation

uses
  usajConstante, uspExcecao, ufpgMensagem3;

const
  nCOD_CERTIFICADO_CPF_VALIDO = 0;
  nCOD_CERTIFICADO_CPF_INVALIDO = 1;
  sCPF_VALIDO = '77472840394';
  sCPF_INVALIDO = '12312312312';


{ TfpgControleCertificadoDigitalFake }

function TfpgControleCertificadoDigitalFake.PegarCPFCertificado(pnIdCertificado: integer): string;
begin
  case pnIdCertificado of
    nCOD_CERTIFICADO_CPF_VALIDO:
    begin
      result := sCPF_VALIDO;
    end;
    nCOD_CERTIFICADO_CPF_INVALIDO:
    begin
      result := sCPF_INVALIDO;
    end;
  end;
end;

end.

