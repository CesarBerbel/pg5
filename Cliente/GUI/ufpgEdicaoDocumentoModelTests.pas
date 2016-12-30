unit ufpgEdicaoDocumentoModelTests;

interface

uses
  ufpgModelTests;

type
  TfpgEdicaoDocumentoModelTests = class(TfpgModelTests)
  private
    FbSelecionarPessoas: boolean;
    FbAbrirDoMenu: boolean;
    FbReservaValores: boolean;
    FbPreencheProcessoNoCompMandado: boolean;
    FsDeFormaPagto: string;
    FsTipoParte: string;
    FsfpgQtdPulic: string;
    FsModelo: string;
    FsNuProcesso: string;
    FsPrazoEdital: string;
    FsCdZona: string;
    FsCategoria: string;
    FsPrazoAto: string;
    FsCdFormaPagto: string;
    FsDeZona: string;
    FsClassificacaoMandado: string;
    FbFecharTela: boolean;
    FsJuiz: string;
    FsEscrivao: string;
    FbVerificarConsultaEndAr: boolean;
    FbEdicaoDocumentoAutomatico: boolean;
    FbEstaPreenchido: boolean;
    FsAgente: string;
  public
    class function VerificarDocEmitido(psCdProcesso, psCdDocumento: string): boolean;
  published
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgCategoria: string read FsCategoria write FsCategoria;
    property fpgModelo: string read FsModelo write FsModelo;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgCdFormaPagto: string read FsCdFormaPagto write FsCdFormaPagto;
    property fpgDeFormaPagto: string read FsDeFormaPagto write FsDeFormaPagto;
    property fpgCdZona: string read FsCdZona write FsCdZona;
    property fpgDeZona: string read FsDeZona write FsDeZona;
    property fpgTipoParte: string read FsTipoParte write FsTipoParte;
    property fpgPrazoEdital: string read FsPrazoEdital write FsPrazoEdital;
    property fpgPrazoAto: string read FsPrazoAto write FsPrazoAto;
    property fpgQtdPulic: string read FsfpgQtdPulic write FsfpgQtdPulic;
    property fpgClassificacaoMandado: string read FsClassificacaoMandado 
      write FsClassificacaoMandado;
    property fpgReservaValores: boolean read FbReservaValores write FbReservaValores;
    property fpgSelecionarPessoas: boolean read FbSelecionarPessoas write FbSelecionarPessoas;
    property fpgPreencheProcessoNoCompMandado: boolean   
      read FbPreencheProcessoNoCompMandado write FbPreencheProcessoNoCompMandado;
    property fpgFecharTela: boolean read FbFecharTela write FbFecharTela;
    property fpgJuiz: string read FsJuiz write FsJuiz;
    property fpgEscrivao: string read FsEscrivao write FsEscrivao;
    property fpgVerificarConsultaEndAr: boolean read FbVerificarConsultaEndAr   
      write FbVerificarConsultaEndAr;
    property fpgEdicaoDocumentoAutomatico: boolean 
      read FbEdicaoDocumentoAutomatico   write FbEdicaoDocumentoAutomatico;
    property fpgEstaPreenchido: boolean read FbEstaPreenchido write FbEstaPreenchido;
    property fpgAgente: string read FsAgente write FsAgente;
  end;

implementation

uses
  usegRepositorio, SysUtils, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

{ TfpgEdicaoDocumentoModelTests }

class function TfpgEdicaoDocumentoModelTests.VerificarDocEmitido(psCdProcesso,
  psCdDocumento: string): boolean;
  //var
  //  osegRepositorio: TesegRepositorio;
  //  sSQL: string;
begin
  result := True;
  //  oSegRepositorio := TesegRepositorio.Create(nil);
  //  try
  //    sSQL := VerificarDocEmitidoSQL(psCdProcesso, psCdDocumento);
  //    oSegRepositorio.SQLOpen(sSQL);
  //    result := oSegRepositorio.FieldByName('DOCEMITIDO').AsInteger = 1;
  //  finally
  //    FreeAndNil(oSegRepositorio);
  //  end;
end;

end.

