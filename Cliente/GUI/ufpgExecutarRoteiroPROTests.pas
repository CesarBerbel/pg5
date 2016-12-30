unit ufpgExecutarRoteiroPROTests;

interface

uses
  ufpgGuiTestCase;

type
  TffpgExecutarRoteiroPROTests = class(TfpgGuiTestCase)
  private
    FsTestePRO: string;
  public
    constructor Create(MethodName: string); reintroduce; overload; override;
  published
    procedure ExecutarTestePRO;
  end;

implementation

uses
  ufpgFuncoesGUITestes, SysUtils;

const
  CS_CAMINHO_PRO = 'C:\SAJ\Clientes\SAJPRO';

{ TffLimparVariaveisTests }

constructor TffpgExecutarRoteiroPROTests.Create(MethodName: string);
begin
  FsTestePRO := MethodName;
  MethodName := 'ExecutarTestePRO';
  inherited Create(MethodName);
end;

procedure TffpgExecutarRoteiroPROTests.ExecutarTestePRO;
begin
  ExecutarEAguardar(CS_CAMINHO_PRO + '\ProAppTests.exe ' + FsTestePRO, False);
end;

end.

