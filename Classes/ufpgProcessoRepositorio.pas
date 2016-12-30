unit ufpgProcessoRepositorio;

interface

uses
  Classes, SysUtils, uspRepositorio, ufpgDocumentoRepositorio, uaipInfracoesPenaisRepositorio;

type

  TfpgProcessoRepositorio = class(TspRepositorio)
  private
    FnPartesAtivas: integer;
    FnPartesPassivas: integer;
    FbCivel: boolean;
    FbDistribuido: boolean;
    FbRegistroSentenca: boolean;
    FbExcepcional: boolean;
    FbDependente: boolean;
    FbSigiloso: boolean;
    FbPendencia: boolean;
    FbFisico: boolean;
    FbMovimentacaoVincDocDigital: boolean;
    FbProcessoApensado: boolean;
    FoDocumentoRepositorio: TfpgDocumentoRepositorio;
    FoInfracoesPenaisRepositorio: TaipInfracoesPenaisRepositorio;
    FbSemCustasIniciais: boolean;
    FbApensar: boolean;
    FbSigilo: boolean;
    FbAlteraClasse: boolean;
    FbPeticao: boolean;

    procedure SetarFbCivel(const pbCivel: boolean);
    procedure SetarFbDependente(const pbDependente: boolean);
    procedure SetarFbDistribuido(const pbDistribuido: boolean);
    procedure SetarFbExcepcional(const pbExcepcional: boolean);
    procedure SetarFbRegistroSentenca(const pbRegistroSentenca: boolean);
    procedure SetarFbSigiloso(const pbSigiloso: boolean);
    procedure SetarFnPartesAtivas(const pnPartesAtivas: integer);
    procedure SetarFnPartesPassivas(const pnPartesPassivas: integer);
    procedure SetarFbPendencia(const pbPendencia: boolean);
    procedure SetarFbFisico(const pbFisico: boolean);
    procedure SetarFoDocumentoRepositorio(const poDocumentoRepositorio: TfpgDocumentoRepositorio);
    procedure SetarFbMovimentacaoVincDocDigital(const pbMovimentacaoVincDocDigital: boolean);
    procedure SetarFbProcessoApensado(const pbProcessoApensado: boolean);
    procedure SetarFbSemCustasIniciais(const pbSemCustasIniciais: boolean);
    procedure SetarFbApensar(const pbApensar: boolean);
    procedure SetarFbSigilo(const pbSigilo: boolean);
    procedure SetarFbAlteraClasse(const pbAlteraClasse: boolean);
    procedure SetarFbPeticao(const pbPeticao: boolean);
  public
    constructor Create; override;

  published
    property fpgPartesAtivas: integer read FnPartesAtivas write SetarFnPartesAtivas;
    property fpgPartesPassivas: integer read FnPartesPassivas write SetarFnPartesPassivas;
    property fpgCivel: boolean read FbCivel write SetarFbCivel;
    property fpgDistribuido: boolean read FbDistribuido write SetarFbDistribuido;
    property fpgRegistroSentenca: boolean read FbRegistroSentenca write SetarFbRegistroSentenca;
    property fpgExcepcional: boolean read FbExcepcional write SetarFbExcepcional;
    property fpgDependente: boolean read FbDependente write SetarFbDependente;
    property fpgSigiloso: boolean read FbSigiloso write SetarFbSigiloso;
    property fpgPendencia: boolean read FbPendencia write SetarFbPendencia;
    property fpgFisico: boolean read FbFisico write SetarFbFisico;
    property fpgMovimentacaoVincDocDigital: boolean 
      read FbMovimentacaoVincDocDigital   write SetarFbMovimentacaoVincDocDigital;
    property fpgProcessoApensado: boolean read FbProcessoApensado write SetarFbProcessoApensado;
    property fpgDocumentoRepositorio: TfpgDocumentoRepositorio   
      read FoDocumentoRepositorio write SetarFoDocumentoRepositorio;
    property fpgInfracoesPenaisRepositorio: TaipInfracoesPenaisRepositorio   
      read FoInfracoesPenaisRepositorio write FoInfracoesPenaisRepositorio;
    property fpgSemCustasIniciais: boolean read FbSemCustasIniciais write SetarFbSemCustasIniciais;
    property fpgApensar: boolean read FbApensar write SetarFbApensar;
    property fpgSigilo: boolean read FbSigilo write SetarFbSigilo;
    property fpgAlteraClasse: boolean read FbAlteraClasse write SetarFbAlteraClasse;
    property fpgPeticao: boolean read FbPeticao write SetarFbPeticao;
  end;

implementation

constructor TfpgProcessoRepositorio.Create;
begin
  inherited;
  spCategoria := 'Processo';
  FnPartesAtivas := 0;
  FnPartesPassivas := 0;
  FbCivel := True;
  FbDistribuido := False;
  FbRegistroSentenca := False;
  FbExcepcional := False;
  FbDependente := False;
  FbSigiloso := False;
  FbPendencia := False;
  FbFisico := False;
  FbApensar := False;
  FbSemCustasIniciais := False;
  FbMovimentacaoVincDocDigital := False;
  FbSigilo := False;
  FbAlteraClasse := False;
  FbPeticao := False;
  FoDocumentoRepositorio := TfpgDocumentoRepositorio.Create; //PC_OK;
  FoInfracoesPenaisRepositorio := TaipInfracoesPenaisRepositorio.Create; //PC_OK;
  AdicionarPropriedadeConsiderada('fpgInfracoesPenaisRepositorio');
end;

procedure TfpgProcessoRepositorio.SetarFbFisico(const pbFisico: boolean);
begin
  FbFisico := pbFisico;
  AdicionarPropriedadeConsiderada('fpgFisico');
end;

procedure TfpgProcessoRepositorio.SetarFbPendencia(const pbPendencia: boolean);
begin
  FbPendencia := pbPendencia;
  AdicionarPropriedadeConsiderada('fpgPendencia');
end;

procedure TfpgProcessoRepositorio.SetarFnPartesAtivas(const pnPartesAtivas: integer);
begin
  FnPartesAtivas := pnPartesAtivas;
  AdicionarPropriedadeConsiderada('fpgPartesAtivas');
end;

procedure TfpgProcessoRepositorio.SetarFnPartesPassivas(const pnPartesPassivas: integer);
begin
  FnPartesPassivas := pnPartesPassivas;
  AdicionarPropriedadeConsiderada('fpgPartesPassivas');
end;

procedure TfpgProcessoRepositorio.SetarFbCivel(const pbCivel: boolean);
begin
  FbCivel := pbCivel;
  AdicionarPropriedadeConsiderada('fpgCivel');
end;

procedure TfpgProcessoRepositorio.SetarFbDistribuido(const pbDistribuido: boolean);
begin
  FbDistribuido := pbDistribuido;
  AdicionarPropriedadeConsiderada('fpgDistribuido');
end;

procedure TfpgProcessoRepositorio.SetarFbRegistroSentenca(const pbRegistroSentenca: boolean);
begin
  FbRegistroSentenca := pbRegistroSentenca;
  AdicionarPropriedadeConsiderada('fpgRegistroSentenca');
end;

procedure TfpgProcessoRepositorio.SetarFbExcepcional(const pbExcepcional: boolean);
begin
  FbExcepcional := pbExcepcional;
  AdicionarPropriedadeConsiderada('fpgExcepcional');
end;

procedure TfpgProcessoRepositorio.SetarFbDependente(const pbDependente: boolean);
begin
  FbDependente := pbDependente;
  AdicionarPropriedadeConsiderada('fpgDependente');
end;

procedure TfpgProcessoRepositorio.SetarFbSigiloso(const pbSigiloso: boolean);
begin
  FbSigiloso := pbSigiloso;
  AdicionarPropriedadeConsiderada('fpgSigiloso');
end;

procedure TfpgProcessoRepositorio.SetarFoDocumentoRepositorio(
  const poDocumentoRepositorio: TfpgDocumentoRepositorio);
begin
  FoDocumentoRepositorio := poDocumentoRepositorio;
  AdicionarPropriedadeConsiderada('fpgDocumentoRepositorio');
end;

procedure TfpgProcessoRepositorio.SetarFbMovimentacaoVincDocDigital(
  const pbMovimentacaoVincDocDigital: boolean);
begin
  FbMovimentacaoVincDocDigital := pbMovimentacaoVincDocDigital;
  AdicionarPropriedadeConsiderada('fpgMovimentacaoVincDocDigital');
end;

procedure TfpgProcessoRepositorio.SetarFbProcessoApensado(const pbProcessoApensado: boolean);
begin
  FbProcessoApensado := pbProcessoApensado;
  AdicionarPropriedadeConsiderada('fpgProcessoApensado');
end;

procedure TfpgProcessoRepositorio.SetarFbSemCustasIniciais(const pbSemCustasIniciais: boolean);
begin
  FbSemCustasIniciais := pbSemCustasIniciais;
  AdicionarPropriedadeConsiderada('fpgSemCustasIniciais');
end;

procedure TfpgProcessoRepositorio.SetarFbApensar(const pbApensar: boolean);
begin
  FbApensar := pbApensar;
  AdicionarPropriedadeConsiderada('fpgApensar');
end;

procedure TfpgProcessoRepositorio.SetarFbSigilo(const pbSigilo: boolean);
begin
  FbSigilo := pbSigilo;
  AdicionarPropriedadeConsiderada('fpgSigilo');
end;

procedure TfpgProcessoRepositorio.SetarFbAlteraClasse(const pbAlteraClasse: boolean);
begin
  FbAlteraClasse := pbAlteraClasse;
  AdicionarPropriedadeConsiderada('fpgAlteraClasse');
end;

procedure TfpgProcessoRepositorio.SetarFbPeticao(const pbPeticao: boolean);
begin
  FbPeticao := pbPeticao;
  AdicionarPropriedadeConsiderada('fpgPeticao');
end;

end.

