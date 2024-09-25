Shader "Graph/Point Surface"
{
    Properties
    {
        _BaseMap ("Base Map", 2D) = "white" {}
        _BaseColor ("Base Color", Color) = (1, 1, 1, 1)
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Varyings
            {
                float4 positionHCS : POSITION;
                float2 uv : TEXCOORD0;
                float3 worldPos : TEXCOORD1;                
            };


            CBUFFER_START(UnityPerMaterial)
                float4 _BaseColor;
                TEXTURE2D(_BaseMap);
                SAMPLER(sampler_BaseMap);
            CBUFFER_END

            Varyings vert (Attributes input)
            {
                Varyings output;
                output.positionHCS = TransformObjectToHClip(input.positionOS.xyz);
                output.uv = input.uv;
                output.worldPos = TransformObjectToWorld(input.positionOS.xyz);
                return output;
            }

            half4 frag (Varyings input) : SV_Target
            {
                float3 worldPosition = input.worldPos;
                half4 baseColor =  saturate(half4(worldPosition.rg * 0.5 + 0.5, 0.0, 0.0 )) * SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, input.uv);;
                return baseColor * _BaseColor;
            }
            ENDHLSL
        }
    }
}
