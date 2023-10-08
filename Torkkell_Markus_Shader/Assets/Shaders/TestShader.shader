Shader "Custom/TestShader"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags {"RenderType"="Opaque" "RenderPipeline" = "UniversalPipeline" "Queue"="Geometry"}

        Pass
        {
            Name "OmaPass"
            Tags
            {
                "LightMode" = "UniversalForward"
            }
        
        
            HLSLPROGRAM

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            
            #pragma  vertex Vert
            #pragma fragment Frag

            struct Attributes
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL; //Tee jotain surface normaleilla
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION;
                float3 positionWS : TEXCOORD0;
            };

            
            CBUFFER_START(UnityPerMaterial)
            float4 _Color;
            CBUFFER_END

            Varyings Vert(const Attributes input)
            {
                Varyings output;

                output.positionHCS = TransformObjectToHClip(input.positionOS);
                output.positionWS = TransformObjectToWorld(input.positionOS);
                
                return output;
            }

            half4 Frag(const Varyings input) : SV_TARGET
            {
                //return half4(input.positionWS, 1);
                return _Color * clamp(input.positionWS.x, 0, 1);
            }

        ENDHLSL


        }
    }
}