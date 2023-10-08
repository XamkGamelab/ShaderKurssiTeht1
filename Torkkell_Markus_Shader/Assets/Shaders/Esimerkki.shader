/*Shader "Custom/Esimerkki"
{
    Properties
    {
        _TestiFloat("Testi float", Float) = 0.5
        [MainColor] _BaseColor("Base Color", Color) = (1, 1, 1, 1)
        [MainTexture] _BaseMap("Base Map", 2D) = "white" { }
    }
    
    CustomEditor "ExampleShaderGUI" // Custom editor GUI
    
    SubShader
    {
        Tags {"RenderType"="Opaque" "RenderPipeline" = "UniversalPipeline" "Queue"="Geometry"}

        HLSLINCLUDE //voi tehdä asioita
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            int num()
            {
                return 4;
            }
        ENDHLSL
        
        Pass {
            Name "ForwardLit"
            Tags { "LightMode" = "UniversalForward" }

            Cull Back //Front, Off
            Blend One Zero //Värien kertominen, source multiplier, destination multiplier
            ZTest LEqual //millä funktiolla testaa Z-arvoa
            ZWrite On //varmasti tekee jotain :D

            HLSLPROGRAM

            #pragma exclude_renderers gles gles3 glcore //ei tue tiettyjä renderöijiä
            #pragma target 4.5 //enemmän featureita
            
            #pragma vertex Vertex
            #pragma fragment Fragment

            // Universal Pipeline keywords, nopein tapa, ei elseifiä
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
            #pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
            #pragma multi_compile_fragment _ _LIGHT_LAYERS
            #pragma multi_compile_fragment _ _LIGHT_COOKIES
            #pragma multi_compile _ _FORWARD_PLUS

            // Unity defined keywords
            #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
            #pragma multi_compile _ SHADOWS_SHADOWMASK
            #pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma multi_compile _ LIGHTMAP_ON
            #pragma multi_compile _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog

            // GPU Instancing
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer

            #include "EsimerkkiProgram.hlsl"

            ENDHLSL
        }
    }
}
*/