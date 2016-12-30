unit ufpgDadosAdicionaisPartesEtiquetaAutuacaoTests;

interface

uses
  ufpgDadosAdicionaisPartesEtiquetaAutuacaoFake, TestFrameWork, Windows, Forms,
  FutureWindows, SysUtils, DB, DBClient, uspTestCase;


type
  TfpgDadosAdicionaisPartesEtiquetaAutuacaoTests = class(TspTestCase)
  private
    FoDadosAdicionaisPartesEtiquetaAutuacao: TfpgDadosAdicionaisPartesEtiquetaAutuacaoFake;
    FoDocsPartes: TClientDataSet;
    procedure CriarDataSetDocsPartes;
  protected
    procedure setup; override;
    procedure TearDown; override;
  published
    procedure TestPegarTextoAdicionalParteCompetenciaNaoImprimeNada;
    procedure TestPegarTextoAdicionalParteCompetenciaSomenteDtNascMasculino;
    procedure TestPegarTextoAdicionalParteCompetenciaSomenteDtNascVaziaCompetenciaImprime;
    procedure TestPegarTextoAdicionalParteCompetenciaSomenteDtNascFeminino;
    procedure TestPegarTextoAdicionalParteCompetenciaSomenteProntuarioCabeNaColuna;
  end;

implementation

uses
  uSajConstante, ufpgDadosAdicionaisPartesEtiquetaAutuacao, Classes;

const
  sCOMP_INEX = '99';
  sCOMP_SOMENTE_DTNASC = '1';
  sCOMP_SOMENTE_PRONTUARIO = '8';
  sCOMP_AMBOS = '875';

  sCDPESSOA_JOAO = '1185292';
  sDTNASCIMENTO_JOAO = '20/09/1987';
  sCDPROCESSOOK_JOAO = 'II0000Q7D0000';
  sPT_JOAO = '128-C';

  sCD_PESSOA_LUIZ = '13985';
  sCDPROCESSOOK_LUIZ = '6D0001AG82310';
  sDTNASCIMENTO_LUIZ = '12/09/1948';
  sPT_LUIZ = '897-C';
  sPT_LUIZ_OVERLOAD = '787987987878888888C1-1A';

  sCDPESSOA_JADILSON = '0000000';
  nTAM_COLUNA = 177;

procedure TfpgDadosAdicionaisPartesEtiquetaAutuacaoTests.setup;
begin
  CriarDataSetDocsPartes;
  FoDadosAdicionaisPartesEtiquetaAutuacao := TfpgDadosAdicionaisPartesEtiquetaAutuacaoFake.Create(FoDocsPartes, nil); //PC_OK
end;

procedure TfpgDadosAdicionaisPartesEtiquetaAutuacaoTests.CriarDataSetDocsPartes;
begin
  FoDocsPartes := TClientDataSet.Create(nil); //PC_OK

  FoDocsPartes.FieldDefs.Add('cdProcesso', ftString, 13);
  FoDocsPartes.FieldDefs.Add('cdPessoa', ftFloat, 0);
  FoDocsPartes.FieldDefs.Add('sgTipoDocumento', ftString, 4);
  FoDocsPartes.FieldDefs.Add('nuDocFormatado', ftString, 50);
  FoDocsPartes.CreateDataSet;
  FoDocsPartes.Active := True;

  FoDocsPartes.insert;
  FoDocsPartes.FieldByName('cdProcesso').AsString := sCDPROCESSOOK_JOAO;
  FoDocsPartes.FieldByName('cdPessoa').AsString := sCDPESSOA_JOAO;
  FoDocsPartes.FieldByName('sgTipoDocumento').AsString := sTIPODOC_PRONTUARIO;
  FoDocsPartes.FieldByName('nuDocFormatado').AsString := sPT_JOAO;
  FoDocsPartes.post;

  FoDocsPartes.insert;
  FoDocsPartes.FieldByName('cdProcesso').AsString := '6D0001AG80000';
  FoDocsPartes.FieldByName('cdPessoa').AsString := sCDPESSOA_JOAO;
  FoDocsPartes.FieldByName('sgTipoDocumento').AsString := 'CPF';
  FoDocsPartes.FieldByName('nuDocFormatado').AsString := '121.717.949-68';
  FoDocsPartes.post;

  FoDocsPartes.insert;
  FoDocsPartes.FieldByName('cdProcesso').AsString := '6D0001AG80000';
  FoDocsPartes.FieldByName('cdPessoa').AsString := '1186212';
  FoDocsPartes.FieldByName('sgTipoDocumento').AsString := sTIPODOC_PRONTUARIO;
  FoDocsPartes.FieldByName('nuDocFormatado').AsString := '777777777777777777';
  FoDocsPartes.post;

  FoDocsPartes.insert;
  FoDocsPartes.FieldByName('cdProcesso').AsString := sCDPROCESSOOK_LUIZ;
  FoDocsPartes.FieldByName('cdPessoa').AsString := sCD_PESSOA_LUIZ;
  FoDocsPartes.FieldByName('sgTipoDocumento').AsString := sTIPODOC_PRONTUARIO;
  FoDocsPartes.FieldByName('nuDocFormatado').AsString := '121';
  FoDocsPartes.post;

  FoDocsPartes.insert;
  FoDocsPartes.FieldByName('cdProcesso').AsString := '6D9999AG80000';
  FoDocsPartes.FieldByName('cdPessoa').AsString := sCD_PESSOA_LUIZ;
  FoDocsPartes.FieldByName('sgTipoDocumento').AsString := sTIPODOC_PRONTUARIO;
  FoDocsPartes.FieldByName('nuDocFormatado').AsString := '121';
  FoDocsPartes.post;
end;

procedure TfpgDadosAdicionaisPartesEtiquetaAutuacaoTests.TearDown;
begin
  FreeAndNil(FoDocsPartes); //PC_OK
end;

procedure TfpgDadosAdicionaisPartesEtiquetaAutuacaoTests.
TestPegarTextoAdicionalParteCompetenciaNaoImprimeNada;
var
  sTxtAdicional: string;
begin
  sTxtAdicional := FoDadosAdicionaisPartesEtiquetaAutuacao.PegarTextoAdicionalParte(
    sCOMP_INEX, sCDPESSOA_JOAO, sDTNASCIMENTO_JOAO, sTP_GENERO_MASCULINO,
    sCDPROCESSOOK_JOAO, nTAM_COLUNA).Text;
  Check(sTxtAdicional = STRING_INDEFINIDO);
end;

procedure TfpgDadosAdicionaisPartesEtiquetaAutuacaoTests.
TestPegarTextoAdicionalParteCompetenciaSomenteDtNascMasculino;
var
  slRetorno: TStringList;
begin
  try
    slRetorno := FoDadosAdicionaisPartesEtiquetaAutuacao.PegarTextoAdicionalParte(
      sCOMP_SOMENTE_DTNASC, sCDPESSOA_JOAO, sDTNASCIMENTO_JOAO, sTP_GENERO_MASCULINO,
      sCDPROCESSOOK_JOAO, nTAM_COLUNA);


    Check((slRetorno.Count = 1) and (slRetorno.IndexOf('(' + sNASC_MASCULINO +
      sDTNASCIMENTO_JOAO + ')') = 0));
  finally
    FreeAndNil(slRetorno); //PC_OK
  end;
end;

procedure TfpgDadosAdicionaisPartesEtiquetaAutuacaoTests.
TestPegarTextoAdicionalParteCompetenciaSomenteDtNascFeminino;
var
  slRetorno: TStringList;
begin
  try
    slRetorno := FoDadosAdicionaisPartesEtiquetaAutuacao.PegarTextoAdicionalParte(
      sCOMP_SOMENTE_DTNASC, sCDPESSOA_JOAO, sDTNASCIMENTO_JOAO, sTP_GENERO_FEMININO,
      sCDPROCESSOOK_JOAO, nTAM_COLUNA);

    Check((slRetorno.Count = 1) and (slRetorno.IndexOf('(' + sNASC_FEMININO +
      sDTNASCIMENTO_JOAO + ')') = 0));
  finally
    FreeAndNil(slRetorno); //PC_OK
  end;
end;

procedure TfpgDadosAdicionaisPartesEtiquetaAutuacaoTests.
TestPegarTextoAdicionalParteCompetenciaSomenteDtNascVaziaCompetenciaImprime;
var
  slRetorno: TStringList;
begin
  try
    slRetorno := FoDadosAdicionaisPartesEtiquetaAutuacao.PegarTextoAdicionalParte(
      sCOMP_SOMENTE_DTNASC, sCDPESSOA_JOAO, STRING_INDEFINIDO, sTP_GENERO_FEMININO,
      sCDPROCESSOOK_JOAO, nTAM_COLUNA);

    Check(slRetorno.Count = 0);
  finally
    FreeAndNil(slRetorno); //PC_OK
  end;
end;

procedure TfpgDadosAdicionaisPartesEtiquetaAutuacaoTests.
TestPegarTextoAdicionalParteCompetenciaSomenteProntuarioCabeNaColuna;
var
  slRetorno: TStringList;
begin
  try
    slRetorno := FoDadosAdicionaisPartesEtiquetaAutuacao.PegarTextoAdicionalParte(
      sCOMP_SOMENTE_PRONTUARIO, sCDPESSOA_JOAO, sDTNASCIMENTO_JOAO, sTP_GENERO_MASCULINO,
      sCDPROCESSOOK_JOAO, nTAM_COLUNA);

    Check((slRetorno.Count = 1) and
      (slRetorno.indexOf('(' + Format(sPT_LINHA_NOVA, [sPT_JOAO]) + ')') = 0));
  finally
    FreeAndNil(slRetorno); //PC_OK
  end;
end;


initialization

  TestFrameWork.RegisterTest('Unitário\ufpgDadosAdicionaisPartesEtiquetaAutuacaoTests',
    TfpgDadosAdicionaisPartesEtiquetaAutuacaoTests.Suite);

end.

