using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using UnityEditor.DeviceSimulation;
using UnityEngine;

public class GOLScript : MonoBehaviour

{
    [SerializeField] private ComputeShader GOLSimulation;
    [SerializeField] private Material VisualizationMaterial;
    [SerializeField] private GameInit Seed;
    [SerializeField] private Color CellCol;
    [SerializeField, Range(0f, 2f)] private float UpdateInterval;

    private float NextUpdate = 2f;
    private static readonly Vector2Int TexSize = new Vector2Int(512, 512);

    public RenderTexture Texture1, Texture2;

    private bool isState1;

    private static int SimulationKernel1, SimulationKernel2, RPentominoKernel, AcornKernel, GunKernel, FullKernel;

    private static readonly int BaseMap = Shader.PropertyToID("_BaseMap");
    private static readonly int CellColour = Shader.PropertyToID("CellColour");
    private static readonly int TextureSize = Shader.PropertyToID("TextureSize");
    private static readonly int State1 = Shader.PropertyToID("Texture1");
    private static readonly int State2 = Shader.PropertyToID("Texture2");

    public enum GameInit
    {
        RPentomino, Acorn, GosperGun, FullTexture
    }




    void Start()
    {
        Texture1 = new RenderTexture(TexSize.x, TexSize.y, 0, UnityEngine.Experimental.Rendering.DefaultFormat.LDR)
        {
            filterMode = FilterMode.Point,
            enableRandomWrite = true
        };

        Texture1.Create();

        Texture2 = new RenderTexture(TexSize.x, TexSize.y, 0, UnityEngine.Experimental.Rendering.DefaultFormat.LDR)
        {
            filterMode = FilterMode.Point,
            enableRandomWrite = true
        };

        Texture2.Create();



        SimulationKernel1 = GOLSimulation.FindKernel("Update1");
        SimulationKernel2 = GOLSimulation.FindKernel("Update2");
        RPentominoKernel = GOLSimulation.FindKernel("InitRPentomino");
        AcornKernel = GOLSimulation.FindKernel("InitAcorn");
        GunKernel = GOLSimulation.FindKernel("InitGun");
        FullKernel = GOLSimulation.FindKernel("InitFullTexture");


    }

    void update1()
    {
        if (Time.time < NextUpdate) return;

        isState1 = !isState1;

        VisualizationMaterial.SetTexture(BaseMap, isState1 ? Texture1 : Texture2);

        NextUpdate = Time.time + UpdateInterval;
    }

    void update2()
    {

    }

    private void OnDisable()
    {
        Texture1.Release();
        Texture2.Release();
    }
    private void OnDestroy()
    {
        Texture1.Release();
        Texture2.Release();
    }


    //GOLSimulation.SetTexture()


    switch Seed
    {

        case GameInit;
    }


    
    Simulator.Dispatch(Seed switch
    {
        GameInit.RPentomino => Simulator.Find("InitRPentomino"),
        GameInit.Acorn => Simulator.FindKernel("InitAcorn"),
        GameInit.GosperGun => Simulator.Find("InitGun"),
        GameInit.FullTexture => Simulator.Find("InitFullTexture"),
        _ => 0
    }, TexSize.x / 8, TexSize.x / 8,);



}
