unit ufpgXMLRecebimentoPeticaoInicialTests;

interface

uses
  Forms, Classes, uspTestCase, ADODB, ufpgGeradorObjetosDeXML, SysUtils,
  TestFrameWork, ufpgXMLPIDInformacoesPeticaoInicialDelegacia;


type
  TfpgXMLRecebimentoPeticaoInicialTests = class(TTestCase)
  private
    FoGeradorObjetosDeXML: TfpgGeradorObjetosDeXML;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestLerXML;
    procedure TestPreenchimentoDadosBasicos;
    procedure TestPreenchimentoDadosPartes;
    procedure TestPreenchimentoDadosEnderecoPartes;
    procedure TestPreenchimentoDadosDocumentosPartes;
    procedure TestPreenchimentoDadosDocIntegrado;

  end;


implementation

{ TfpgXMLRecebimentoPeticaoInicialTests }

procedure TfpgXMLRecebimentoPeticaoInicialTests.SetUp;
begin
  inherited;
  FoGeradorObjetosDeXML := TfpgGeradorObjetosDeXML.Create; //PC_Ok
end;

procedure TfpgXMLRecebimentoPeticaoInicialTests.TearDown;
begin
  inherited;
  FreeAndNil(FoGeradorObjetosDeXML); //PC_OK
end;

procedure TfpgXMLRecebimentoPeticaoInicialTests.TestLerXML;
var
  sPath: string;
  oPeticaoInicial: TfpgXMLPIDInformacoesPeticaoInicialDelegacia;
begin
  sPath := ExtractFilePath(Application.ExeName);

  oPeticaoInicial := TfpgXMLPIDInformacoesPeticaoInicialDelegacia.Create(  //PC_OK
    '', 0, 0, 0, //ql
    '', '', 0, '', //ql
    '', '', '', '', '', '', '');

  FoGeradorObjetosDeXML.PreencherObjetoComXML(sPath + 'Tests\input\PeticaoInicialDelegacia1.0.xml',
    TObject(oPeticaoInicial));
end;

procedure TfpgXMLRecebimentoPeticaoInicialTests.TestPreenchimentoDadosBasicos;
var
  sPath: string;
  oPeticaoInicial: TfpgXMLPIDInformacoesPeticaoInicialDelegacia;
begin
  sPath := ExtractFilePath(Application.ExeName);
  oPeticaoInicial := TfpgXMLPIDInformacoesPeticaoInicialDelegacia.Create(  //PC_OK
    '', 0, 0, 0, //ql
    '', '', 0, '', //ql
    '', '', '', '', '', '', '');

  FoGeradorObjetosDeXML.PreencherObjetoComXML(sPath + 'Tests\input\PeticaoInicialDelegacia1.0.xml',
    TObject(oPeticaoInicial));

  Check(oPeticaoInicial.fpgpidSequencialProc = '12999999012314');
  Check(oPeticaoInicial.fpgpidDataHora = '2009-11-30T13:55:15.659');
  Check(oPeticaoInicial.fpgpidIdentificadorDocumento = '12qwe4234rsdr324r43rt4r789789789');
  Check(oPeticaoInicial.fpgProcesso = '00006706720118270001');
  Check(oPeticaoInicial.fpgcdForo = 1);
  Check(oPeticaoInicial.fpgCdCompetencia = '123');
  Check(oPeticaoInicial.fpgCdClasse = '3216');
  Check(oPeticaoInicial.fpgCdDelegacia = '123');
  Check(oPeticaoInicial.fpgNmAutoridadePolicial = 'Delegado XXXX');
  Check(oPeticaoInicial.fpgDtOcorrencia = '25/01/2009');
  Check(oPeticaoInicial.fpgAssuntos.fpgCdAssuntoPrincipal = '1');
  Check(oPeticaoInicial.fpgAssuntos.fpgCdOutroAssunto.Strings[0] = '6');
  Check(oPeticaoInicial.fpgFlUrgente = 'S');
  Check(oPeticaoInicial.fpgflPreso = 'N');
end;

procedure TfpgXMLRecebimentoPeticaoInicialTests.TestPreenchimentoDadosPartes;
var
  sPath: string;
  oPeticaoInicial: TfpgXMLPIDInformacoesPeticaoInicialDelegacia;
begin
  sPath := ExtractFilePath(Application.ExeName);
  oPeticaoInicial := TfpgXMLPIDInformacoesPeticaoInicialDelegacia.Create(  //PC_OK
    '', 0, 0, 0, //ql
    '', '', 0, '', //ql
    '', '', '', '', '', '', '');

  FoGeradorObjetosDeXML.PreencherObjetoComXML(sPath + 'Tests\input\PeticaoInicialDelegacia1.0.xml',
    TObject(oPeticaoInicial));

  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgNuSeqPessoa = '1');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgCdTipoParte = '2');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgParteDesconhecida = 'S');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgTpPessoa = 'F');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgNmPessoa = 'João Capone');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgTpGenero = 'M');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgCdEstadoCivil = '1');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgCdNacionalidade = '1');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgCdProfissao = '3');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgDtNascimento = '20/01/1967');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgNmPai = 'Pedro Paulo Capone Silva');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgNmMae = 'Maria Fátima Capone');
end;

procedure TfpgXMLRecebimentoPeticaoInicialTests.TestPreenchimentoDadosEnderecoPartes;
var
  sPath: string;
  oPeticaoInicial: TfpgXMLPIDInformacoesPeticaoInicialDelegacia;
begin
  sPath := ExtractFilePath(Application.ExeName);
  oPeticaoInicial := TfpgXMLPIDInformacoesPeticaoInicialDelegacia.Create(  //PC_OK
    '', 0, 0, 0, //ql
    '', '', 0, '', //ql
    '', '', '', '', '', '', '');

  FoGeradorObjetosDeXML.PreencherObjetoComXML(sPath + 'Tests\input\PeticaoInicialDelegacia1.0.xml',
    TObject(oPeticaoInicial));

  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgEndereco.fpgDeEndereco
    = 'Rua Pedro de Oliveira');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgEndereco.fpgNuEndereco = '15');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgEndereco.fpgComplementoEndereco = 'casa');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgEndereco.fpgDeBairro = 'Centro');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgEndereco.fpgCdMunicipio = 3);
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgEndereco.fpgNuCEP = '36800114');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgEndereco.fpgUfEndereco = 'SP');
end;

procedure TfpgXMLRecebimentoPeticaoInicialTests.TestPreenchimentoDadosDocIntegrado;
var
  sPath: string;
  oPeticaoInicial: TfpgXMLPIDInformacoesPeticaoInicialDelegacia;
begin
  sPath := ExtractFilePath(Application.ExeName);
  oPeticaoInicial := TfpgXMLPIDInformacoesPeticaoInicialDelegacia.Create(  //PC_OK
    '', 0, 0, 0, //ql
    '', '', 0, '', //ql
    '', '', '', '', '', '', '');

  FoGeradorObjetosDeXML.PreencherObjetoComXML(sPath + 'Tests\input\PeticaoInicialDelegacia1.0.xml',
    TObject(oPeticaoInicial));

  Check(oPeticaoInicial.fpgpidDocIntegrado.fpgpidDadosDoc.Items[0].fpgpidNome
    = 'PeticaoInicialDelegacia0001.pdf');
  Check(oPeticaoInicial.fpgpidDocIntegrado.fpgpidDadosDoc.Items[0].fpgpidPidDigestValue
    = 'ea19570c7a8b6bdfc160f48245224e2ab819c027');
  Check(oPeticaoInicial.fpgpidDocIntegrado.fpgpidDadosDoc.Items[0].fpgpidcdTipoDocumentoDigital
    = 1);
  Check(oPeticaoInicial.fpgpidDocIntegrado.fpgpidDadosDoc.Items[1].fpgpidNome
    = 'PeticaoInicialDelegacia0002.pdf');
  Check(oPeticaoInicial.fpgpidDocIntegrado.fpgpidDadosDoc.Items[1].fpgpidPidDigestValue
    = 'ea19570c7a8b6bdfc160f48245224e2ab819c028');
  Check(oPeticaoInicial.fpgpidDocIntegrado.fpgpidDadosDoc.Items[1].fpgpidcdTipoDocumentoDigital
    = 2);
end;

procedure TfpgXMLRecebimentoPeticaoInicialTests.TestPreenchimentoDadosDocumentosPartes;
var
  sPath: string;
  oPeticaoInicial: TfpgXMLPIDInformacoesPeticaoInicialDelegacia;
begin
  sPath := ExtractFilePath(Application.ExeName);
  oPeticaoInicial := TfpgXMLPIDInformacoesPeticaoInicialDelegacia.Create(  //PC_OK
    '', 0, 0, 0, //ql
    '', '', 0, '', //ql
    '', '', '', '', '', '', '');

  FoGeradorObjetosDeXML.PreencherObjetoComXML(sPath + 'Tests\input\PeticaoInicialDelegacia1.0.xml',
    TObject(oPeticaoInicial));

  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgDocumentos.fpgDocumento.items[
    0].fpgSgTipoDocumento = 'RG');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgDocumentos.fpgDocumento.items[
    0].fpgNuDocumento = '3566444');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgDocumentos.fpgDocumento.items[
    0].fpgDeOrgaoExpedidor = 'SSP-SP');

  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgDocumentos.fpgDocumento.items[
    1].fpgSgTipoDocumento = 'CPF');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgDocumentos.fpgDocumento.items[
    1].fpgNuDocumento = '72306220697');

  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgDocumentos.fpgDocumento.items[
    2].fpgSgTipoDocumento = 'OAB');
  Check(oPeticaoInicial.fpgPartes.fpgParte.Items[0].fpgDocumentos.fpgDocumento.items[
    2].fpgNuDocumento = '1111111111/SP');

end;

initialization
  TestFramework.RegisterTest(
    'Unitário\pg5\Componentes\pg5Componentes\ufpgXMLRecebimentoPeticaoInicialTests',
    TfpgXMLRecebimentoPeticaoInicialTests.Suite);

end.

