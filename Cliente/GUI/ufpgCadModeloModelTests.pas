unit ufpgCadModeloModelTests;

interface

uses
  ufpgCadModelo, ufpgModelTests, ADODB, uspClientDataSet;

type
  TffpgCadAtoModelTests = class(TfpgModelTests)
  private
    FsAto: string;
    FsModoFinalizacao: string;
    FsPrazo: string;
    FsModelo: string;
    FsForma: string;
    FsAutomatico: string;
    FsTpSelecao: string;
    FbVerificarModelo: boolean;
  published
    property fpgAto: string read FsAto write FsAto;
    property fpgForma: string read FsForma write FsForma;
    property fpgModelo: string read FsModelo write FsModelo;
    property fpgPrazo: string read FsPrazo write FsPrazo;
    property fpgAutomatico: string read FsAutomatico write FsAutomatico;
    property fpgTpSelecao: string read FsTpSelecao write FsTpSelecao;
    property fpgModoFinalizacao: string read FsModoFinalizacao write FsModoFinalizacao;
  end;


  TffpgCadMovimentacaoModelTests = class(TfpgModelTests)
  private
    FsTpMovimentacao: string;
  published
    property fpgTpMovimentacao: string read FsTpMovimentacao write FsTpMovimentacao;

  end;


  TffpgCadModeloModelTests = class(TfpgModelTests)
  private
    FsNomeModelo: string;
    FsCdCategoria: string;
    FoCadAtoModelTests: TffpgCadAtoModelTests;
    FoCadMovimentacaoModelTests: TffpgCadMovimentacaoModelTests;
    FbVerificarModelo: boolean;
  public
    destructor Destroy; override;
    procedure CarregarModelTest(poCDS: TspClientDataSet); override;
  published
    property fpgCdCategoria: string read FsCdCategoria write FsCdCategoria;
    property fpgNomeModelo: string read FsNomeModelo write FsNomeModelo;
    property fpgCadMovimentacaoModelTests: TffpgCadMovimentacaoModelTests   
      read FoCadMovimentacaoModelTests write FoCadMovimentacaoModelTests;
    property fpgCadAtoModelTests: TffpgCadAtoModelTests 
      read FoCadAtoModelTests   write FoCadAtoModelTests;
    property fpgVerificarModelo: boolean read FbVerificarModelo write FbVerificarModelo;
  end;

implementation

{ TffpgCadModeloModelTests }

uses
  SysUtils;

procedure TffpgCadModeloModelTests.CarregarModelTest(poCDS: TspClientDataSet);
begin
  inherited;
  fpgCadMovimentacaoModelTests := TffpgCadMovimentacaoModelTests.Create; //PC_OK
  fpgCadAtoModelTests := TffpgCadAtoModelTests.Create; //PC_OK
end;

destructor TffpgCadModeloModelTests.Destroy;
begin
  inherited;
  FreeAndNil(FoCadMovimentacaoModelTests); //PC_OK
  FreeAndNil(FoCadAtoModelTests); //PC_OK
end;

end.

